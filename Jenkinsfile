pipeline {
  agent any

  options {
    timestamps()
  }

  environment {
    ENV = "${env.BRANCH_NAME}"
    TF_WORKDIR = "environments/${env.BRANCH_NAME}"
  }

  stages {

    stage('Checkout') {
      steps {
        cleanWs()
        git branch: "${env.BRANCH_NAME}",
            url: 'https://github.com/Susmitha789257/InfraPipeline.git'
      }
    }

    stage('Terraform Init') {
      steps {
        dir("${TF_WORKDIR}") {
          withAWS(credentials: 'aws-creds', region: 'ap-northeast-3') {
            sh 'terraform init -input=false'
          }
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        dir("${TF_WORKDIR}") {
          sh 'terraform validate'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        dir("${TF_WORKDIR}") {
          withAWS(credentials: 'aws-creds', region: 'ap-northeast-3') {
            sh 'terraform plan -out=tfplan -input=false'
          }
        }
      }
    }

    stage('Approval') {
      when {
        branch 'production'
      }
      steps {
        input message: "Approve deployment to PRODUCTION?", ok: 'Deploy'
      }
    }

    stage('Terraform Apply') {
      steps {
        dir("${TF_WORKDIR}") {
          withAWS(credentials: 'aws-creds', region: 'ap-northeast-3') {
            script {
              if (env.BRANCH_NAME == 'production') {
                sh 'terraform apply tfplan'
              } else {
                sh 'terraform apply -auto-approve'
              }
            }
          }
        }
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}

