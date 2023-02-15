# Cloud&DevOps Fundamentals Autumn 2022 my Final Project with CI/CD as example petclinic. 

This is files used by Jenkins in jobs. 

### /
### /Jenkinsfile  
> Job "petclinic-terraform" - create Infrastructure environment dev or main. Can apply or destroy it. Create dev-host.html or main-host.html file and copy it to http://vladimir-rogovenko.pp.ua/
### /main/Jenkinsfile
> Job "main-CD-petclinic" - take last build artifact from S3 bucket and run (or rerun if exists) it on main-srv. Besides recovery (execute) for DB "petclinic" files from petclinic/mysql_db/conf.d/petclinic_backup_1.sql (git repo).
### /main/network.tf outputs.tf instance.tf config.tf vars.tf main-srv_user_data.sh
> Terrraforms files that describe networks, outputs variables, instances parameters, global config like backend .tfstate and region, all uses variables and user_data.sh file for instance creation.
### /dev/Jenkinsfile
> Job "petclinic-build". Use for building artifact. Run on Jenkins-Node-1 instance. Get petclinic/src and pom.xml from git, install maven with environments, run tests and build package. Store artifact to S3 bucket. Can building for dev or main git branch petclinic. If dev branch - add Time and Build Number stamps to end of welcome.html page.
### /dev/*.tf files and *_user_data.sh files
> Terraform files like /main/*.tf described above, but for "dev" environment (creation 2 instances: dev-srv and jenkins-node + reconnect jenkins node to Jenkins-master as node and test it).
### /dev/CD/Jenkinsfile
> Job "dev-CD-petclinic". Run Ansible playbook from ansible-dev-srv.yaml. This playbook do next steps: install boto3 on server for aws_s3, clone repo petclinic, Get LAST artifact from S3, Docker build container spring-openjdk:1.3 from Dockerfile, run docker-compose.yml. 
### /dev/CD/hosts
> servers host list for Ansible playbook
### /dev/CD/Dockerfile
> Dockerfile for creation image based on openjdk:latest
### /dev/CD/docker-compose.yml
> docker-compose file for Docker. Run 2 containers: from my image spring-openjdk:1.3 and mysql:5.7 with volumes for DB
### /global/groovy/reconnect.groovy 
> groovy script uses in ReConnect Jenkins job for connecting jenkins-node-1 to Jenkins-master
### /global/Create_S3_artifacts_storage
> Terraform files for create S3 bucket s3_artifacts_storage and access policy. Run onece if bucket not exists.
### /global/Create_S3_tfstate_bucket
> Terraform files for create bucket tfstate-final-project-java2022


