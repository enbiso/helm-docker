#!/bin/bash
if [ -z $KUBECONFIG_BASE64 ]; then
    echo "Set the env variable KUBECONFIG_BASE64"
else
    mkdir -p /root/.kube     
    echo "Initializing Kubecli and Helm"
    echo $KUBECONFIG_BASE64 | base64 -d > /root/.kube/config; 
    kubectl cluster-info; 
    helm init --client-only; 
    export KUBE_INITIALIZED=yes
fi
