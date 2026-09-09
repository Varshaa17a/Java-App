pipeline {
    agent any
    tools{
        maven 'maven'
    }

    environment {
        DOCKER_IMAGE  = "vsasdfghjk/java_app"
        GITOPS_REPO   = ""
        MAVEN_OPTS    = "-Dmaven.test.skip=true"
        SONAR_SERVER = "sonarqube-server"
        SONAR_PROJECT = ""
        EMAIL_TO      = "vps17aug@gmail.com"
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage("Code Checkout") {
            steps {
                checkout scm
            }
        }

        stage("Compile Code") {
            steps {
                sh "mvn clean package ${MAVEN_OPTS}"
            }
        }

//         stage('SonarQube Scan') {
//     steps {
//         withSonarQubeEnv(SONAR_SERVER) {
//             sh "mvn sonar:sonar -Dsonar.projectKey=${SONAR_PROJECT}"
//         }
//     }
// }

//         stage("Quality Gate") {
//             steps {
//                 timeout(time: 1, unit: 'MINUTES') {
//                     waitForQualityGate abortPipeline: true
//                 }
//             }
//         }

        stage("Identify Environment") {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/dev') {
                        env.ENV = 'dev'
                    } else if (env.GIT_BRANCH == 'origin/main') {
                        env.ENV = 'prod'
                    } else {
                        error "Unsupported branch: ${env.GIT_BRANCH}"
                    }
                }
            }
        }

        stage("Generate Image Tag") {
            steps {
                script {
                    if (env.ENV == 'dev') {
                        env.IMAGE_TAG = "${BUILD_NUMBER}-dev"
                    } else {
                        env.IMAGE_TAG = "${BUILD_NUMBER}"
                    }
                }
            }
        }

        stage("Docker Build") {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
            }
        }

        // stage("Trivy Scan") {
        //     steps {
        //         sh "trivy image --severity CRITICAL,HIGH --exit-code 1 ${DOCKER_IMAGE}:${IMAGE_TAG}"
        //     }
        // }
    }

    post {
        success {
            echo "success!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
//             emailext(
//                 subject: "SUCCESS: ${JOB_NAME} #${BUILD_NUMBER}",
//                 body: """
// Deployment SUCCESSFUL

// Env   : ${env.ENV}
// Image : ${DOCKER_IMAGE}:${IMAGE_TAG}
// URL   : ${BUILD_URL}
// """,
//                 to: "${EMAIL_TO}"
//             )
        }

        failure {
            echo "failure!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
//             emailext(
//                 subject: "FAILED: ${JOB_NAME} #${BUILD_NUMBER}",
//                 body: """
// Deployment FAILED

// Env : ${env.ENV}
// URL : ${BUILD_URL}
// """,
//                 to: "${EMAIL_TO}"
//             )
        }

        always {
            echo "clean ws here.. ok..........."
            // cleanWs()
        }
    }
}
