pipeline {

    parameters {
        //string(name: 'environment', defaultValue: 'dev', description: 'Workspace/environment file to use for deployment')
        choice(name: "environment", choices: ["dev", "main"], description: "Environment dir to use for deployment")
        booleanParam(name: 'destroyNode', defaultValue: false, description: 'Automatically destroy Jenkins-Node after build?')
    }


     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    agent { label 'jenkins-master' }
        options {
                timestamps ()
            }
    stages {
        /*
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
        */
        stage('Terraform') {
            steps {
                sh 'pwd;cd ${environment} ; terraform init -input=false -no-color'
                sh 'pwd;cd ${environment} ; terraform apply -auto-approve -no-color'
                sleep(100)
            }
        }

        stage('ReConnectNodes') {
            steps {
                echo '=== start ReConnectNodes ===='
                build job: 'ReConnectNodes'
                echo '=== end ReConnectNodes ===='
            }
        }
        stage('Run 2nd job') {
            steps {
                echo '=== start run 2nd job  ====' 
                echo "env = ${environment} $environment" //working both ))) becouse must be ""  and may try: env.environment
                build job: 'Job_for_start_after_main_job', parameters: [string(name: 'environment', value: "${environment}")]
                echo '=== end run 2nd job  ===='
            }
        }
    }
  }
