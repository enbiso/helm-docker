#!/bin/bash
if [ -z $INITIALIZED ]; then
    source /scripts/init.sh
fi
TEMP=`getopt -o n:g:h::s:: --long name:,namespace:,hosts::,set:: -n helm.sh -- "$@"`
if [[ $? -ne 0 ]]; then
    exit 2
fi
DEPLOY_SETTINGS=""
eval set -- "$TEMP"
while true; do
    case "$1" in
        -n|--name)      DEPLOY_NAME=$2;                                                     shift 2 ;;
        -g|--namespace) DEPLOY_NAMESPACE=$2;                                                shift 2 ;;
        -h|--hosts)     DEPLOY_SETTINGS="${DEPLOY_SETTINGS} --set ingress.hosts={${2}}";    shift 2 ;;
        -s|--set)       DEPLOY_SETTINGS="${DEPLOY_SETTINGS} ${2}"                           shift 2 ;;
        --)             shift; break                                                                ;;
        *)              echo "Internal error"; exit 3                                               ;;
    esac
done

deploys=$(helm ls | grep ${DEPLOY_NAME} | wc -l)
if [ ${deploys} -eq 0 ]; then    
    echo "Installing ${DEPLOY_NAME} on ${DEPLOY_NAMESPACE} with ${DEPLOY_SETTINGS}"
    helm install --name=${DEPLOY_NAME} . --namespace=${DEPLOY_NAMESPACE} ${DEPLOY_SETTINGS}
else 
    echo "Upgrading ${DEPLOY_NAME} on ${DEPLOY_NAMESPACE} with ${DEPLOY_SETTINGS}"
    helm upgrade ${DEPLOY_NAME} . --namespace=${DEPLOY_NAMESPACE} ${DEPLOY_SETTINGS}
fi