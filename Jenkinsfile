pipeline {
    agent any
    // tools {
    //     maven "3.8.5"
    // }
    stages {
        stage('Pull code') {
            steps {
                // Pull code from source control repository
                git branch: 'master', url: 'https://github.com/LeHuuVu99/university_management.git'
            }
        }
        stage('Compile and Clean') {
            steps {
                // Run Maven on any agent.
                sh "mvn clean compile"
            }
        }
        stage('deploy') {
            steps {
                sh "mvn package"
            }
        }
        stage('Push code') {
            steps {
                // Push code to source control repository
                gitPush(branch: 'master')
            }
        }
        stage('Archiving') {
            steps {
                archiveArtifacts '**/target/*.jar'
            }
        }
    }
}
