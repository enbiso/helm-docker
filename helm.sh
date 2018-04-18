#!/bin/bash
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -n|--name)
    DEPLOY_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    -ns|--namespace)
    DEPLOY_NAMESPACE="$2"
    shift # past argument
    shift # past value
    ;;
esac
done
deploys=$(helm ls | grep $DEPLOY_NAME | wc -l)
if [ ${deploys} -eq 0 ]; then    
    echo "Installing ${DEPLOY_NAME} on ${DEPLOY_NAMESPACE}"
    helm install --name=${DEPLOY_NAME} . --namespace=${DEPLOY_NAMESPACE}; 
else 
    echo "Upgrading ${DEPLOY_NAME} on ${DEPLOY_NAMESPACE}"
    helm upgrade ${DEPLOY_NAME} . --namespace=${DEPLOY_NAMESPACE}; 
fi