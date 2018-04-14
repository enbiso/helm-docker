# kube-deploy
Minimal Kubenetes deploying docker container
 - kubectl
 - helm

Environmental variables
 - `KUBECONFIG_BASE64`
 
    base64 encoded content of the kube config file (optional). This will auto initiate helm and kubectl

## Usage

 - Simple
 
   `docker run enbiso/helm`

 - Advance
 
   `docker run enbiso/helm -e KUBECONFIG_BASE64=XXXXXXXXXXXXXXXXXXXXXXXXXX`
