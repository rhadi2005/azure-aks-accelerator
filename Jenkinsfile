pipeline {
    agent any

    environment {
        KUBECONFIG = credentials('172e8deb-2b4a-4f4c-b794-9d33370f51ea') // ID d'identification Kubeconfig dans Jenkins
        K8S_NAMESPACE = 'default' //  le nom de votre namespace Kubernetes
        K8S_DEPLOYMENT = 'drupal' // le nom de votre déploiement Kubernetes
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
                    def drupalImage = docker.build('drupal:8.6')
                    drupalImage.push()
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                script {
                    container(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl') {
                        withCredentials([file(credentialsId: '172e8deb-2b4a-4f4c-b794-9d33370f51ea', variable: 'KUBECONFIG')]) {
                            sh """
                                kubectl config use-context rmt-aks-iac
                                kubectl apply -f /kubernetes/drupal.yaml -n \${K8S_NAMESPACE}
                                kubectl rollout restart deployment/\${K8S_DEPLOYMENT} -n \${K8S_NAMESPACE}
                            """
                        }
                    }
                }
            }
        }
    }
}
