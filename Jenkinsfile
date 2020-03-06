pipeline {
  environment {
    registry = "raulhsj/jenkins-node-sample"
    registryCredential = 'raulhsj/******'
    dockerImage = ''
  }
  agent any
  tools { nodejs "node 12.15.0" }
  stages {
    stage('Checking out and setting up project') {
      node {
        checkout scm

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
