pipeline {
  environment {
    registryCredential = 'raulhsj/******'
    dockerImage = ''
  }
  agent any
  tools {
    nodejs "node 12.15.0"
    'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'latest'
  }
  stages {
    stage('Checkout-git') {
      steps {
        git poll: true, credentialsId: 'cadc4801-ca68-4fdd-8aa7-46fcd9e4b976', url: 'git@github.com:raulhsj/tests-jenkins-1.git'
      }
    }
    stage('Going to target dir') {
      steps {
        sh '''
          cd jenkins-node-sample
          npm i
          npm run cover
        '''
      }
    }
    stage('Building dockerHub image') {
      steps {
        script {
          docker.withServer('tcp://socat:2375') {
            sh 'docker build -t jenkins-node-sample:latest'
          }
        }
      }
    }
    stage('Deploy dockerHub image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            docker.withServer('tcp://socat:2375') {
              sh 'docker push raulhsj/jenkins-node-sample'
            }
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        script {
          docker.withServer('tcp://socat:2375') {
            sh 'docker rmi $registry:latest'
          }
        }
      }
    }
  }
}
