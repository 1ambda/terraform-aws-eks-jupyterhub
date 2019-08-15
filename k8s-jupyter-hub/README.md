# k8s-jupyter-hub

## Preparation 

- [x] Modify `{EFS-ID}` value in `k8s.efs-volume.yaml`

```bash
# will create EBS, EFS k8s resources for jupyter hub
./jupyter.helm-prepare.sh
```

## Installation

Set these values in in `jupyter.helm-config.yaml`

- [ ] `secretToken`
- [x] `service.beta.kubernetes.io/aws-load-balancer-extra-security-groups`

```bash
# install jupyterhub helm chart
./jupyter.helm-install.sh

# monitor jupyter hub pods are being installed 
kubectl get pods -n jupyter-production -w
```

## Update 

Execute this command to update jupyter hub helm chart.

```bash
./jupyter.helm-update.sh
```

## Setup Github OAuth

- [x] Create [Github Secret for OAuth Authentication](https://github.com/settings/apps) 
- [x] Setup [Github Secret for Jupyterhub Authentication](https://zero-to-jupyterhub.readthedocs.io/en/latest/authentication.html) 
- [x] Modify `auth.type` and `auth.github` in `jupyter.helm-config.yaml` 

```bash
./jupyter.helm-update.sh
```
