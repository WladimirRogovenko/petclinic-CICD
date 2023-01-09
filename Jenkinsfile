pipeline {

    parameters {
        //string(name: 'environment', defaultValue: 'dev', description: 'Workspace/environment file to use for deployment')
        choice(name: "environment", choices: ["dev", "main"], description: "Environment dir to use for deployment")
    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
        options {
                timestamps ()
            }
    stages {
        stage('Git checkout project') {
            steps {
                 script{
                        echo '=== start Git chekout project ==='
                        dir("project")
                        {
                            git branch: '${environment}', credentialsId: 'jenkis-git-key', url: 'git@github.com:WladimirRogovenko/petclinic-CICD.git'
                        }
                        echo '=== end Git chekout project ==='
                    }
                }
            }
        stage('TerraformCreateNode') {
            steps {
                sh 'pwd;cd project/${environment} ; terraform init -input=false'
                sh 'pwd;cd project/${environment} ; terraform apply -auto-approve'
                sleep(90)
            }
        }

        stage('ReConnectNodes') {
            steps {
                echo '=== start ReConnectNodes ===='
                //sh 'pwd;cd project/${environment} ; pwd; ls -la'
                //script {
                //def groovy_script = load 'global/groovy/reconnect.groovy'
                //def groovy_script = evaluate readTrusted('global/groovy/reconnect.groovy')
                //echo 'start Groovy script'
                //groovy_script.groovy_script()
                //}
                build job: 'ReConnectNodes'
                echo '=== end ReConnectNodes ===='
            }
        }
        stage('Run 2nd job') {
            steps {
                echo '=== start run 2nd job  ====' 
                echo "${environment} $environment" //working both ))) becouse must be ""  and may try: env.environment
                build job: 'Job_for_start_after_main_job', parameters: [string(name: 'environment', value: "${environment}")]
                echo '=== end run 2nd job  ===='
            }
        }
    }
  }
