![Alt text](Network%20Diagram.png?raw=true "Network Diagram")

- Project architecture:

1) Traffic is routed on the behalf of Cloudflare to one of the load balancers. One is Green and one is Blue. It is decided upon the 'color' parameter that you specified during the Jenkins build*[1]
2) Web requests are processed by AWS Autoscaling group which runs Nginx with PHP-FPM running on AWS Linux.
3) Database administration can be done at https://misha-krik.xyz/phpmyadmin . It is done by an EC2 instance with Nginx, PHP-FPM and Phpmyadmin installed. 
4) Database requests are managed by AWS RDS instance which is available for instances in both public subnets via port 3306.

- How is it built?

This application is built on host node only. I did not want to get a more powerful machine on AWS, GCP or any other cloud provider, but still wanted to practise Jenkins in a pair with Docker. 

Jenkins simply connects to Docker via a Unix socket ( /var/run/docker.sock ) and each stage of the build is done by a separate Docker container which is composed from Dockerfiles located in this repository (/jenkins/ansible-slave and /jenkins/terraform-slave). 

After having its job done, container dies freeing up the resources.

- How should it be deployed?

1) The only required software on the host machine is Jenkins and Docker. Make sure that Docker is connected to Jenkins via a UNIX socket. This should be done in the configuration of Docker plugin in Jenkins itself.
2) Create a new pipeline item in Jenkins.
3) In the 'Pipeline' section choose 'Pipeline script from SCM', Git as SCM, use this repository's URL: https://github.com/mishakrik2/devpro and use a pre-existing key. You can obtain the key by contacting me directly.
4) Branch should be specified as */jenkins
5) Relative path to the Jenkinsfile is jenkins/pipeline/Jenkinsfile .
6) Save the pipeline.
7) Now it can be executed properly.*[1]

- Disaster recovery plan:

In order to apply the infrastructure in any other region, you should locate the vars file of terraform ( terraform/blue/vars.tf ), change the AWS_REGION variable value to a desired one ( eu-west-2 ). Also, do not forget to change availability zones as well. They are defined in AWS_AVAIL_ZONE_1 and AWS_AVAIL_ZONE_2 variables. Change their values respectively ( eu-west-2a and eu-west-2b ). 

List of availability zones can be found here: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html

Make sure to create a new branch for this change and push your repo there. Jenkins build should be made from the newly created branch as well.

*[1]Please keep in mind that the first build with most certainly fail because of Jenkins parameters from the pipeline not being fetched from the repository yet! The second build should already have correct choice parameters.*

*[2]Blue-green switch:

At the start of the Jenkins build, you can choose a type of deployment that will be used as a primary one to serve your web requests.

The only difference is the CNAME record applied to the root domain and the www subdomain of misha-krik.xyz domain name on Cloudflare. CNAME record has a value of one of the Application Load Balancers' DNS names.