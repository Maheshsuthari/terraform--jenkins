#Create infrastructure as a code with Terraform 
## IAAS with CI with jenkins and ansible
Prerequisites
We need jenkins server configured with plugins Terraform, Ansible and should be installed Terraform, anisble, pip boto3 
you should configure .aws/credentials in jenkins server
Clone this project
git clone https://github.com/Maheshsuthari/terraform--jenkins.git

cd terraform--jenkins

you can just run ansible-playbook s3-bucket, terraform.yaml 

terraform init 
terraform apply --auto-aprove

##I have created few resources vpc, ec2, elb 
or 

go to jenkins server and create pipline with this git hub respository

and just run Buildnow once you satisfy Prerequisites

#######################3



