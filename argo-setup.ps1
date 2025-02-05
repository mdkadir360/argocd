

kubectl create namespace argocd
 
 kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd --type="merge" -p '{\"spec\": {\"type\": \"LoadBalancer\"}}'

# Get the password


$encodedPassword = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"
[System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($encodedPassword))

# Get the external IP
$externalIP = kubectl get svc argocd-server -n argocd -o jsonpath="{.status.loadBalancer.ingress[0].ip}"
Write-Output "ArgoCD Server External IP: $externalIP"
