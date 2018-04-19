#!/bin/bash
if [ ! -z $1 ]; then
    KUBECONFIG_BASE64=$1
fi
if [ -z $KUBECONFIG_BASE64 ]; then
    echo "Usage: init.sh <BASE64 encoded Kube Config file> (or set the env variable KUBECONFIG_BASE64)"
    exit 2
fi
mkdir -p /root/.kube     
echo "Initializing Kubecli and Helm"
echo $KUBECONFIG_BASE64 | base64 -d > /root/.kube/config; 
kubectl cluster-info; 
helm init --client-only; 