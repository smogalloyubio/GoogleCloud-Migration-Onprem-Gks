# Download the binary
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

# Make it executable
sudo chmod +x /usr/local/bin/argocd

# Verify it works
argocd version --client


 
kubectl create namespace argocd

# 2. Apply the installation manifests
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml