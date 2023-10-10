pipeline {

  agent { label 'docker-slave' }

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
  }

  stages {

    stage('SCM Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/aksingh02/notejam-app.git'
      }
    }
    
    stage('Build') {
      steps {
        sh 'docker build -t aks0207/ansible-notejam:${BUILD_NUMBER} .'
      }
    }
    
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    
    stage('Push') {
      steps {
        sh 'docker push aks0207/ansible-notejam:${BUILD_NUMBER}'
      }
    }

    stage('Get-Ansible-Playbook') {
      steps {
        git branch: 'main', url: 'https://github.com/aksingh02/notejam-ansible.git'
      }
    }
    
    stage('Execute Ansible') {
      steps {
        ansiblePlaybook(credentialsId: 'private-key', inventory: '/etc/ansible/hosts', playbook: 'notejam-deploy.yaml', extraVars: [
                             jenkins_build_number: "${BUILD_NUMBER}"
                         ])
      }
    }

  }
}
