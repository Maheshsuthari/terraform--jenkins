pipeline{
  agent any
  environment {
    TF_HOME = tool name: 'terraform', type: 'org.jenkinsci.plugins.terraform.TerraformInstallation'
    PATH = "$TF_HOME:$PATH"
    //PATH = "${PATH}:${getTerraformPath()}"
  }
  stages{
    stage('S3 - create bucket'){
      steps{
        sh "ansible-playbook s3-bucket.yml"
      }
    }
    stage('terraform init and apply - dev'){
      steps{
        sh returnStatus: true, script: 'terraform workspace new dev'
        sh "terraform init"
        sh "terraform apply -auto-aprove"
      }
    }

    stage('terraform init and apply - prod'){
      steps{
        sh returnStatus: true, script: 'terraform workspace new prod'
        sh "terraform init"
        sh "terraform apply -auto-approve"
      }
    }
  }
}

//def getTerraformPath(){
//  def tfHome = tool name: 'terraform', type: 'org.jenkinsci.plugins.terraform.TerraformInstallation'
//  return tfHome
//}
