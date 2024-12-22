pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sshagent(credentials: ['webuxlab-blog']) {
                    withCredentials([string(credentialsId: 'webuxlab-blog-ssh', variable: 'SSHINFO')]) {
                        sh "ssh -o StrictHostKeyChecking=no $SSHINFO 'mkdir -p /srv/time/www/'"
                        sh "scp -v -r -o StrictHostKeyChecking=no ./docker-compose.yml ${SSHINFO}:/srv/time/"
                        sh "scp -v -r -o StrictHostKeyChecking=no ./Dockerfile ${SSHINFO}:/srv/time/"
                        sh "scp -v -r -o StrictHostKeyChecking=no ./www/ ${SSHINFO}:/srv/time/"
                        sh "ssh -o StrictHostKeyChecking=no $SSHINFO 'pushd /srv/time; docker compose build || exit 1; popd;'"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sshagent(credentials: ['webuxlab-blog']) {
                    withCredentials([string(credentialsId: 'webuxlab-blog-ssh', variable: 'SSHINFO')]) {
                        sh "ssh -o StrictHostKeyChecking=no $SSHINFO 'pushd /srv/time; docker compose up -d || exit 1; popd;'"
                    }
                }
            }
        }
    }
}
