#!/bin/bash

function helmAddKasten(){
    helm repo add kasten https://charts.kasten.io/
    helm repo update
}

echo "Add Kasten to Helm"
helmAddKasten
echo "create Namespache kasten-io"
kubectl create namespace kasten-io

echo "install kasten with Helm"
helm install k10 kasten/k10 --namespace kasten-io \
    --set secrets.azureTenantId=<TENANTID> \
    --set secrets.azureClientId=<CLIENTID> \
    --set secrets.azureClientSecret=<SECRET>
