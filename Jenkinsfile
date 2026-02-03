pipeline{
    agent any

    environment{
        docker_image = "vsasdfghjk/java_app"
        gitops_repo = ""
        MAVEN_OPTS = "-Dmaven.test.skip=true"
        SONAR_SERVER = ""
        SONAR_PROJECT = ""

    }

    options{
        timestamps()
        disableConcurrentBuilds()
    }

    stages{
        stage("code checkout"){
            steps{
            checkout scm}
        }

        stage("compile code"){
            steps{
            mvn clean compile $MAVEN_OPTS
            }
        }
        stage("sonarqube scan"){
            steps{
            withSonarQubeEnv("${SONAR_SERVER}"){
                sh " mvn sonar:sonar -Dsonar.projectkey = ${SONAR_PROJECT}"
            }}

        stage("Quality gate"){
            steps{
            timeout(time = 1, units = MINUTES){
                waitForQualityGate abortPipeline: true
            }
            }

        stage("Identify environment"){
            steps{
                if (env.BRANCH_NAME == 'dev'){
                 env.ENV = 'dev' 
                }
                else if (env.BRANCH_NAME == 'main'){
                    env.ENV = 'prod'
                }
            }

        }
         stage("generate tag for image"){
            steps{
                if (env.ENV == 'dev'){
                 env.image_tag =  ${BUILD_NUMBER}-dev 
                }
                else if (env.ENV == 'prod'){
                 env.image_tag =  ${BUILD_NUMBER} 
                }

            }

        }
        stage("docker build"){
            steps{
                sh "docker build -t ${docker_image} : ${image_tag}"
            }
        }
         stage("Trivy scan"){
            steps{
                sh "Trivy image --severity = CRITCAL, HIGH --exit-code =1  ${docker_image} : ${image_tag}"
            }
        }


        }

        }
    }












































}
