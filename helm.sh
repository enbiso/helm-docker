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
    -h|--hosts)
    DEPLOY_SETTINGS="$DEPLOY_SETTINGS --set ingress.hosts={$2}"
    shift # past argument
    shift # past value
    ;;
    --set)
    DEPLOY_SETTINGS="$DEPLOY_SETTINGS --set $2"
    shift # past argument
    shift # past value
    ;;
esac
done
deploys=$(helm ls | grep $DEPLOY_NAME | wc -l)
if [ ${deploys} -eq 0 ]; then    
    echo "Installing ${DEPLOY_NAME} on ${DEPLOY_NAMESPACE} with ${DEPLOY_SETTINGS}"
    helm install --name=${DEPLOY_NAME} . --namespace=${DEPLOY_NAMESPACE} ${DEPLOY_SETTINGS}
else 
    echo "Upgrading ${DEPLOY_NAME} on ${DEPLOY_NAMESPACE} with ${DEPLOY_SETTINGS}"
    helm upgrade ${DEPLOY_NAME} . --namespace=${DEPLOY_NAMESPACE} ${DEPLOY_SETTINGS}
fi