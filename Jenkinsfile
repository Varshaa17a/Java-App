pipeline {
 agent any
 tools{}
 environment{
 ENV = 'prod'}
  
 stages{
  stage('Git Checkout'){
  steps{
  Git scm checkout
  echo '{$env.ENV}' 
  }}
  stage(' Build using Maven'){
  steps{sh 'mvn clean compile'
  }}
  when { expression {env.ENV=='prod'}}
  stage('Prod Stage using when'){}
  
  when { expression {env.ENV=='dev'}}
  stage('dev Stage using when'){}
  
  // stage('Create Docker Image and push it' ){
  // steps{ sh 'docker login -u -p'
  //    sh ' docker build .'
	 // sh ' docker push'}}
	 
  // stage('sonarqube'){}
  // stage('owasp check'){}
  // stage('EKS'){}
  }
  
 

 post{
 always{ echo 'Always block'}
 success{ echo 'Successful block'}
 failure{echo 'failure block'}
 unstable{ echo 'unstable - atleast one stage failed - warning'  }
 }
}
