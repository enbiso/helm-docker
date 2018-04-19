#!/bin/bash
mkdir -p /root/.kube     
if [ ! -z ${KUBECONFIG_BASE64} ]; then 
    echo "KUBECONFIG_BASE64 found and auto initializing..."
    echo ${KUBECONFIG_BASE64} | base64 -d > /root/.kube/config; 
    kubectl cluster-info; 
    helm init --client-only; 
else
    echo "KUBECONFIG_BASE64 not found for auto initialize."
fi