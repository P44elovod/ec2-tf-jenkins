pipeline {
  environment {
    registry = 'dockerhub_username'
    registryCredential = 'dockerhub_id'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning our Git') {
      steps {
        git 'https://github.com/P44elovod/nodejs-demoapp.git'
      }
    }
    stage('Building image') {
      steps {
        script {
          dockerImage = docker.build(registry + "/my-app:$BUILD_NUMBER", "-f ./build/Dockerfile .")
        }
      }
    }
    stage('Deploy image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Cleaning up') {
      steps {
        sh "docker rmi $registry/my-app:$BUILD_NUMBER"
      }
    }
  }
}