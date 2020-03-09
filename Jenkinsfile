pipeline {
  environment {
    registryCredential = '3b10e746-e780-43ff-bf9c-70792aad6d47'
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
            sh '''
              cd jenkins-node-sample
              docker build -t jenkins-node-sample:latest .
            '''
          }
        }
      }
    }
    stage('Deploy dockerHub image') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: '3b10e746-e780-43ff-bf9c-70792aad6d47', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
            docker.withServer('tcp://socat:2375') {
              sh '''
                docker login -u $USER -p $PASSWORD
                docker push raulhsj/jenkins-node-sample'
              '''
            }
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        script {
          docker.withServer('tcp://socat:2375') {
            sh 'docker rmi jenkins-node-sample:latest'
          }
        }
      }
    }
  }
}
