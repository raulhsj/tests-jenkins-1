node {

  environment {
    registry = "jenkins-node-sample"
    registryCredential = '3b10e746-e780-43ff-bf9c-70792aad6d47'
    dockerImage = ''
  }

  tools { nodejs "node 12.15.0" }

  stage('Clone repository') {
      /* Let's make sure we have the repository cloned to our workspace */

      checkout scm
  }

  stage('Going to target dir') {
    sh '''
      cd jenkins-node-sample
      npm i
      npm run cover
    '''
  }

  stage('Building dockerHub image') {
    dockerImage = docker.build registry + ":$BUILD_NUMBER"
  }

  stage('Deploy dockerHub image') {
    docker.withRegistry('', registryCredential) {
      dockerImage.push()
    }
  }
  stage('Remove Unused docker image') {
    sh 'docker rmi $registry:$BUILD_NUMBER'
  }
}
