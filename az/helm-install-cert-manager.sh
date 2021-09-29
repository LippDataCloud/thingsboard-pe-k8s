#!/bin/bash

function installCertmanager(){
    helm repo add jetstack https://charts.jetstack.io
    helm repo update

    helm install \
    cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --version v1.5.3 \
    --create-namespace \
    --set installCRDs=true
}

installCertmanager

kubectl apply -f cert-issuer.yaml
kubectl apply -f cert.yaml
kubectl apply -f routes-cert.yml
