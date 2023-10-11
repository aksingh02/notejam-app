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
        ansiblePlaybook(credentialsId: 'private-key', inventory: 'inventory.ini', playbook: 'playbooks/notejam-deploy.yaml', extraVars: [
          docker_image_name: "aks0207/ansible-notejam",
          docker_image_tag: "${BUILD_NUMBER}",
          docker_container_name: "notejam",
          docker_volume_name: "notejam"
        ])
      }
    }

  }
}
