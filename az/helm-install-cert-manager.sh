#!/bin/bash

function installCertmanager(){
    helm install \
    cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --version v1.5.3 \
    --create-namespace \
    --set installCRDs=true
}

kubectl apply -f cert-issuer.yaml

