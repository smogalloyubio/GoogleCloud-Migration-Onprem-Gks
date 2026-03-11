# Download the installer script and run it
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash

# Move the binary to your local bin so you can run 'kustomize' from anywhere
sudo mv kustomize /usr/local/bin/

# Verify it works
kustomize version