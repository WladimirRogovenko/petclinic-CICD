//terrform-dev
import hudson.model.*
pipeline {

    parameters {
        choice(name: "environment", choices: ["dev", "main"], description: "Environment dir to use for deployment")
        choice(name: "terraformAction", choices: ["apply", "destroy"], description: "Terraform action")
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
        stage('Terraform') {
            steps {
                sh 'pwd;cd ${environment} ; terraform init -input=false -no-color'
                sh 'pwd;cd ${environment} ; terraform ${terraformAction} -auto-approve -no-color'
                //sleep(1)
            }
        }
        stage('Copy InAccesseble page to S3/dev-hosts.html') {
            when {
                allOf {
                        environment name: 'terraformAction', value: 'destroy'
                        environment name: 'environment', value: 'dev'
                }
            }
            steps {
                    echo '=== start Copy InAccesseble page to S3/dev-hosts.html  ====' 
                    sh '''
                        cd ${environment}
                        pwd
                        
                        CURRDATE=$(date)
                        echo '===== Create dev-hosts.html =========================='
                        cat <<- EOF > ./dev-hosts.html
                        <html>
                        <head>
                        <title> Dev-srv links </title>
                        </head>
                        <body>
                        <p> Sorry, but DEV-srv was not created. Please, create first.
                        <p> DEV-srv was destroyed: $CURRDATE
                        </body>
                        </html>
                        EOF
                        cat ./dev-hosts.html
                        '''.stripIndent()
                    echo '=== finish create dev-hosts.html =========================='
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 's3-artifact_storage_petclinic', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                      sh "pwd;cd ${environment}; aws s3 cp ./dev-hosts.html s3://vladimir-rogovenko.pp.ua/dev-hosts.html"
                } 
                    echo '=== finish Copy InAccesseble page to S3/dev-hosts.html  ====' 
            }
        }

        stage('Copy links server to S3/dev-hosts.html') {
            when {
                allOf {
                        environment name: 'terraformAction', value: 'apply'
                        environment name: 'environment', value: 'dev'
                }
            }
            steps {
                    echo '=== start Copy links server to S3/dev-hosts.html  ====' 
                    sh '''
                        cd ${environment}
                        pwd
                        
                        terraform output aws_instance_dev-srv_public_ip -no-color
                        echo 'second'
                    
                        DEVPUBIP=$(terraform output aws_instance_dev-srv_public_ip -no-color | tr -d \\")
                        echo DEVPUBIP = $DEVPUBIP
                        CURRDATE=$(date)
                        echo '===== Create dev-hosts.html =========================='
                        cat <<- EOF > ./dev-hosts.html
                        <html>
                        <head>
                        <title> Dev-srv links </title>
                        </head>
                        <body>
                        <p> Links to servers
                        <a href="http://$DEVPUBIP:8082/">dev-srv</a>
                        <p> File created: $CURRDATE
                        </body>
                        </html>
                        EOF
                        cat ./dev-hosts.html
                        '''.stripIndent()
                    echo '=== finish create dev-hosts.html =========================='
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 's3-artifact_storage_petclinic', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                      sh "pwd;cd ${environment}; aws s3 cp ./dev-hosts.html s3://vladimir-rogovenko.pp.ua/dev-hosts.html"
                } 
                    echo '=== finish Copy links server to S3/dev-hosts.html  ====' 
            }
        }
        
        stage('Copy InAccesseble page to S3/main-hosts.html') {
            when {
                allOf {
                        environment name: 'terraformAction', value: 'destroy'
                        environment name: 'environment', value: 'main'
                }
            }
            steps {
                    echo '=== start Copy InAccesseble page to S3/main-hosts.html  ====' 
                    sh '''
                        cd ${environment}
                        pwd
                        
                        CURRDATE=$(date)
                        echo '===== Create dev-hosts.html =========================='
                        cat <<- EOF > ./main-hosts.html
                        <html>
                        <head>
                        <title> Dev-srv links </title>
                        </head>
                        <body>
                        <p> Sorry, but MAIN-srv was not created. Please, create first.
                        <p> DEV-srv was destroyed: $CURRDATE
                        </body>
                        </html>
                        EOF
                        cat ./main-hosts.html
                        '''.stripIndent()
                    echo '=== finish create main-hosts.html =========================='
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 's3-artifact_storage_petclinic', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                      sh "pwd;cd ${environment}; aws s3 cp ./main-hosts.html s3://vladimir-rogovenko.pp.ua/main-hosts.html"
                } 
                    echo '=== finish Copy InAccesseble page to S3/main-hosts.html  ====' 
            }
        }

        stage('Copy links server to S3/main-hosts.html') {
            when {
                allOf {
                        environment name: 'terraformAction', value: 'apply'
                        environment name: 'environment', value: 'main'
                }
            }
            steps {
                    echo '=== start Copy links server to S3/main-hosts.html  ====' 
                    sh '''
                        cd ${environment}
                        pwd
                        
                        terraform output aws_instance_main-srv_public_ip -no-color
                        echo 'second'
                    
                        DEVPUBIP=$(terraform output aws_instance_main-srv_public_ip -no-color | tr -d \\")
                        echo DEVPUBIP = $DEVPUBIP
                        CURRDATE=$(date)
                        echo '===== Create dev-hosts.html =========================='
                        cat <<- EOF > ./main-hosts.html
                        <html>
                        <head>
                        <title> Main-srv links </title>
                        </head>
                        <body>
                        <p> Links to servers
                        <a href="http://$DEVPUBIP/">dev-srv</a>
                        <p> File created: $CURRDATE
                        </body>
                        </html>
                        EOF
                        cat ./main-hosts.html
                        '''.stripIndent()
                    echo '=== finish create main-hosts.html =========================='
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 's3-artifact_storage_petclinic', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                      sh "pwd;cd ${environment}; aws s3 cp ./main-hosts.html s3://vladimir-rogovenko.pp.ua/main-hosts.html"
                } 
                    echo '=== finish Copy links server to S3/main-hosts.html  ====' 
            }
        }        
        
        
        stage('Wait Node-1 OnLine') {
            when {
                allOf {
                    environment name: 'terraformAction', value: 'apply'
                    environment name: 'environment', value: 'dev'
                }
            }
            options {
              timeout(time: 5, unit: 'MINUTES')   // timeout on this stage
            }
            steps {
               
                    script {
                        while (hudson.model.Hudson.instance.getNode("jenkins-node-1").toComputer().isOnline()==false)
                            {
                                echo "=== try ReConnect to Jenkins-Node-1 and sleep 10 sec"
                                build job: 'ReConnectNodes'
                                sleep 10
                                echo "=== ReConnectNodes finished ==="
                            }
                    }

            }  
        }

        stage('Run 2nd job') {
            when {
                allOf {
                    environment name: 'terraformAction', value: 'apply'
                    environment name: 'environment', value: 'dev'
                }
            }
            steps {
                echo '=== start run 2nd job  ====' 
                echo "env = ${environment} $environment" //working both ))) becouse must be ""  and may try: env.environment
                build job: 'Job_for_start_after_main_job', parameters: [string(name: 'environment', value: "${environment}")]
                echo '=== end run 2nd job  ===='
            }
        }
    }
  }
