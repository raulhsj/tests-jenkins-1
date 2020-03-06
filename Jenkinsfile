pipeline {
  environment {
    registry = "raulhsj/jenkins-node-sample"
    registryCredential = 'raulhsj/******'
    dockerImage = ''
  }
  agent {
    label 'dockerCloud'
  }
  tools { nodejs "node 12.15.0" }
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
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy dockerHub image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh 'docker rmi $registry:$BUILD_NUMBER'
      }
    }
  }
}
