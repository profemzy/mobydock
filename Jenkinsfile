pipeline {
    agent any
    environment {
        //be sure to replace "profemzy" with your own Docker Hub username
        APP_IMAGE_NAME = "profemzy/mobydock"
        POSTGRES_IMAGE_NAME = "profemzy/mobydock-postgres"
        REDIS_IMAGE_NAME = "profemzy/mobydock-redis"
    }
    stages {
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build(APP_IMAGE_NAME)
                    app.inside {
                        sh 'echo "Test" '
                    }
                    app_db = docker.build(POSTGRES_IMAGE_NAME)
                    app_redis = docker.build(REDIS_IMAGE_NAME)
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                        app_db.push("${env.BUILD_NUMBER}")
                        app_db.push("latest")
                        app_redis.push("${ env.BUILD_NUMBER}")
                        app_redis.push("latest")
                    }
                }
            }
        }
    }
}