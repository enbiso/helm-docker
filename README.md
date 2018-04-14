# kube-deploy
Minimal Kubenetes deploying docker container
 - kubectl
 - helm

Environmental variables
 - KUBECONFIG_BASE64 - base64 encoded content of the kube config file (optional). This will auto initiate helm and kubectl

## Usage

 - Simple
 
   `docker run enbiso/helm`

 - With KUBECONFIG
 
   `docker run enbiso/helm -e KUBECONFIG_BASE64=XXXXXXXXXXXXXXXXXXXXXXXXXX`

 - Execute and login to bash
 
   `docker run -it enbiso/helm`
 
   `docker run -it enbiso/helm -e KUBECONFIG_BASE64=XXXXXXXXXXXXXXXXXXXXXXXXXX`
