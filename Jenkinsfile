node {

  environment {
    registry = "raulhsj/jenkins-node-sample"
    registryCredential = 'raulhsj/******'
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
