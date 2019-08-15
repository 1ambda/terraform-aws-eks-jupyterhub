# k8s-jupyter-hub

## Setup variables

- [x] Modify EFS value in `k8s.efs-volume.yaml`
- [x] Create `secretToken` 
- [X] Configure `service.beta.kubernetes.io/aws-load-balancer-extra-security-groups`
- [ ] Create [Github Secret for OAuth Authentication](https://github.com/settings/apps) 
- [ ] Setup [Github Secret for Jupyterhub Authentication](https://zero-to-jupyterhub.readthedocs.io/en/latest/authentication.html) 
- [ ] Modify `auth.type` and `auth.github`

```bash
aws eks update-kubeconfig --name analysis-production 

kubectl apply -f k8s.ebs-storage-class.yaml 

# modify {EFS-ID} and apply `k8s.efs-volume.yaml`
kubectl apply -f k8s.efs-volume.yaml 
```

## Installation

```bash
# install jupyterhub helm chart
./jupyter.helm-install.sh

# monitor jupyterhub pods are being installed 
kubectl get pods -n jupyter-production -w
```

## Upgrade

```bash
# modify `jupyter.helm-config.yaml`, then 
./jupyter.helm-update.sh
```