pipeline  {
    agent any

    environment {
        FE_SWR_CREDENTIALS_LOGIN    = credentials('FE_SWR_CREDENTIALS_LOGIN')
        FE_SWR_CREDENTIALS_PASSWORD = credentials('FE_SWR_CREDENTIALS')
        FE_SWR_URL = "registry.eu-west-0.prod-cloud-ocb.orange-business.com"
        FE_SWR_ORGANIZATION = "cicd_test"
        DOCKER_IMAGENAME = "pong_pipeline"

    }

    stages {

        stage ('Build') {
            steps {
                echo "Building the Docker Image"
                sh "docker build -t ${FE_SWR_URL}/${FE_SWR_ORGANIZATION}/${DOCKER_IMAGENAME}:${env.BUILD_ID} ./Build/."
            }
        }
        stage ('Register') {
            steps {
                echo "Register the Docker Image to SWR"
                sh "docker login -u ${FE_SWR_CREDENTIALS_LOGIN} -p ${FE_SWR_CREDENTIALS_PASSWORD} ${FE_SWR_URL}"

                echo "Register image ${FE_SWR_URL}/${FE_SWR_ORGANIZATION}/${DOCKER_IMAGENAME}:${env.BUILD_ID}"
                sh "docker push ${FE_SWR_URL}/${FE_SWR_ORGANIZATION}/${DOCKER_IMAGENAME}:${env.BUILD_ID}"

                sh "docker tag ${FE_SWR_URL}/${FE_SWR_ORGANIZATION}/${DOCKER_IMAGENAME}:${env.BUILD_ID} ${FE_SWR_URL}/${FE_SWR_ORGANIZATION}/${DOCKER_IMAGENAME}:latest"

                echo "Register image ${FE_SWR_URL}/${FE_SWR_ORGANIZATION}/${DOCKER_IMAGENAME}:latest"
                sh "docker push ${FE_SWR_URL}/${FE_SWR_ORGANIZATION}/${DOCKER_IMAGENAME}:latest"
            }
        }

        stage ('Deploy to FE CCE') {
            steps {
                echo "Deploy to CCE"
                withKubeConfig([credentialsId: 'mykubeconfig']) {
                    sh "kubectl delete deployment.apps/cicd"
                    sh "kubectl create  -f ./Deployments/AppsDeployment.yaml"
                    sh "kubectl delete service/cicd"
                    sh "kubectl create  -f ./Deployments/AppsService.yaml"
                }
            }
        }
    }
}
