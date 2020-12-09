pripeline{
    agent any
    environment {
        PATH = "${PATH}:${getTerraformPath()}"
    }
    stages{
        stage('terraform init and apply - dev'){
            steps{
                sh returnStatus:true script: 'terraform workspace new dev'
                sh "terraform init"
                sh "terraform apply -auto-approve"
            }
        stage('terraform init and apply - qa'){
            steps{
                sh returnStatus:true script: 'terraform workspace new qa'
                sh "terraform init"
                sh "terraform apply -auto-approve"
            }
        }

    }
}
def getTerraformPath(){
    def tfHome = tool name: 'terraform', type: 'org.jenkisci.plugins.terraform.Terraforminstallation'
    return tfHome
}