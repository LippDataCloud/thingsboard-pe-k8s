# Setup Azure AKS

## Create AKS Cluster

Create AKS cluster
[Doc](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal)


## Setup Kubernetes Cluser

### Installation

Follow instruction of #Installation from [README.md](README.md).

### Certificate with Let's Encrypt

Create Cretificate with Let's Encrypt.

[Artifac thub](https://artifacthub.io/packages/helm/cert-manager/cert-manager)


1. Install Cert-manager

```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.5.3 \
  --create-namespace \
  --set installCRDs=true
```

2. Create Cluster cert issuer
   
Now you need to configure an Issuer. You can create an let's encrypt or selfsigned issuer for example.

```yaml
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
    name: letsencrypt-issuer
spec:
    acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: user@example.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
        name: letsencrypt-issuer-key
    # Enable the HTTP-01 challenge provider
    solvers:
    - http01:
        ingress:
            class:  nginx
```
Link to documentation of how to
[Configure issuer](https://cert-manager.io/docs/tutorials/acme/ingress/#step-6-configure-let-s-encrypt-issuer).

3. Cert Certificate for domain

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ui-cert
spec:
  secretName: ui-certificate
  issuerRef:
    name: letsencrypt-issuer
  dnsNames:
  - your.domain.com
```

4. Assing certificate to nginx ingress

[Cert-Manger Ingress](https://cert-manager.io/docs/usage/ingress/)

Add annotation and tls to routes.yaml

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tb-ingress
  namespace: thingsboard
  annotations:
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "3600"
    cert-manager.io/issuer: "letsencrypt-issuer"
spec:
  tls:
    - hosts:
        - tb.gateway.uno
      secretName: tb-certificate
  rules:
    - host: tb.gateway.uno
      http:
        paths:
          - path: /api/v1/integrations.*
            pathType: Prefix
            backend:
              service:
                name: tb-node
                port:
                  number: 8080
      ...
```

### Self Registration

Installation link to self registration

[Doc](https://thingsboard.io/docs/pe/user-guide/self-registration/#step-1-install-thingsboard-in-the-cloud)