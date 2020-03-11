pipeline {
  environment {
    registry = "raulhsj/jenkins-node-sample"
    registryCredential = 'raulhsj-DockerHub'
    dockerImage = ''
  }
  agent any
  tools {
    nodejs "node 12.15.0"
  }
  stages {
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
          sh 'cd jenkins-node-sample'
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
          /* docker.withRegistry('http://localhost:5000') {
            dockerImage.push()
          } */
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
