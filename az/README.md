# Third Party Tools

## Cert-Manager

Install certmanager for Let's encrypt certificate to use for HTTPS connection on thingsboard.

### Modify DNS Name

Modify the DNS name in cert.yaml for your right dns name.

### Install all by script

Run *helm-install-cert-manager.sh* script in order to setup Cert-Manager and the cert's with the right routes.

[Doku Cert-Manager.io](https://cert-manager.io/docs/installation/)

## Kasten-io

### Installation

Before you can start the Kasten Installation, you need to ceate an * Azure App Registrierung* which needs access to the AKS Cluster.
Then fill out the `<>` fields in the kasten-install.sh script file. 

[Doku](https://docs.kasten.io/install/azure/azure.html)

### Configuration

After the Installation, you also need to make some Configuration to store you backup data on an external drive in the Cloud.

#### External Ingress

[Kasten Doku](https://docs.kasten.io/access/dashboard.html#existing-ingress-controller)