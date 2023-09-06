
https://github.com/paulbouwer/hello-kubernetes
image: paulbouwer/hello-kubernetes:1.8

az aks get-credentials --resource-group rmt-rg-aks-iac --name rmt-aks-iac
    Merged "rmt-aks-iac" as current context in /home/ubuntu/.kube/config

kubectl get nodes

export KUBECONFIG="${PWD}/../02_aks_cluster/kubeconfig"
kubectl get node --kubeconfig $KUBECONFIG

kubectl apply -f deployment.yaml
kubectl get pods

kubectl port-forward $(kubectl get pod -l name=hello-kubernetes --no-headers | awk '{print $1}') 8080:8080


kubectl apply -f service.yaml
kubectl apply -f service-loadbalancer.yaml
kubectl apply -f ingress.yaml

