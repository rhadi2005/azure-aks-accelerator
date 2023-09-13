pipeline {
    agent any

    environment {
        KUBECONFIG = credentials('172e8deb-2b4a-4f4c-b794-9d33370f51ea') // ID de vos informations d'identification Kubeconfig
        K8S_NAMESPACE = 'drupal-namespace' // Remplacez par le nom de votre namespace Kubernetes
        K8S_DEPLOYMENT = 'drupal-deployment' // Remplacez par le nom de votre déploiement Kubernetes
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    def drupalImage = docker.build('your-drupal-image-name')
                    drupalImage.push()
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    container(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl') {
                        withCredentials([file(credentialsId: 'your-kubeconfig-credentials-id', variable: 'KUBECONFIG')]) {
                            sh """
                                kubectl config use-context your-aks-context
                                kubectl apply -f your-drupal-deployment.yaml -n \${K8S_NAMESPACE}
                                kubectl rollout restart deployment/\${K8S_DEPLOYMENT} -n \${K8S_NAMESPACE}
                            """
                        }
                    }
                }
            }
        }
    }
}
