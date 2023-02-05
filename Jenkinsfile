//terrform-dev
import hudson.model.*
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
        stage('Terraform') {
            steps {
                sh 'pwd;cd ${environment} ; terraform init -input=false -no-color'
                sh 'pwd;cd ${environment} ; terraform apply -auto-approve -no-color'
                //sleep(120)
            }
        }
        stage('Copy links server to S3') {
            steps {
                //script {
                    echo '=== start Copy links server to S3  ====' 
                    //#!/bin/bash
                    sh ```
                        cd ${environment}
                        DEVPUBIP=`terraform output aws_instance_dev-srv_public_ip -no-color` | tr -d \"
                        echo DEVPUBIP = $DEVPUBIP
                        echo '===== Create dev-hosts.html =========================='
                        #cat <<EOF> ./dev-hosts.html
                        #<html>
                        #<head>
                        #<title> Dev-srv links </title>
                        #</head>
                        #<body>
                        #<p> Links to servers
                        #<a href="http://$DEVPUBIP:8082/">dev-srv</a>
                        #</body>
                        #</html>
                        #EOF
                        echo '===== finish create dev-hosts.html =========================='
                    ```
                    //echo '=== finish Copy links server to S3  ====' 
                //}
            }
        }
        stage('Wait Node-1 OnLine') {
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
            steps {
                echo '=== start run 2nd job  ====' 
                echo "env = ${environment} $environment" //working both ))) becouse must be ""  and may try: env.environment
                build job: 'Job_for_start_after_main_job', parameters: [string(name: 'environment', value: "${environment}")]
                echo '=== end run 2nd job  ===='
            }
        }
    }
  }
