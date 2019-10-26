# k8s-jupyter-hub

## Preparation 

- [x] Modify `{EFS-ID}` value in `k8s.efs-volume.yaml` ([AWS EFS Console](https://ap-northeast-2.console.aws.amazon.com/efs/home?region=ap-northeast-2#/filesystems))

```bash
# will create EBS, EFS k8s resources for jupyter hub
./jupyter.helm-prepare.sh
```

## Installation

Set these values in in `jupyter.helm-config.yaml`

- [ ] `secretToken`
- [x] `service.beta.kubernetes.io/aws-load-balancer-extra-security-groups (eks-public-lb-production Group ID)`

```bash
# install jupyterhub helm chart
./jupyter.helm-install.sh

# monitor jupyter hub pods are being installed 
kubectl get pods -n jupyter-production -w

# check load balancer DNS
kubectl --namespace=jupyter-production get svc proxy-public

NAME           TYPE           CLUSTER-IP     EXTERNAL-IP                                                                    PORT(S)                      AGE
proxy-public   LoadBalancer   172.20.50.70   XXX-YYYY.ap-northeast-2.elb.amazonaws.com   80:30906/TCP,443:32326/TCP   33m
```

Then, visit [a load balancer DNS](https://ap-northeast-2.console.aws.amazon.com/ec2/home?region=ap-northeast-2#LoadBalancers:tag:kubernetes.io/cluster/analysis-production=owned;sort=loadBalancerName) which has a tag `kubernetes.io/cluster/analysis-production:owned`

Initial username and password are `1ambda / mypassword`. If you want to add / modify, then update file [jupyter.helm-config.yaml](https://github.com/1ambda/terraform-aws-eks-jupyterhub/blob/master/k8s-jupyter-hub/jupyter.helm-config.yaml#L41-L50)'s auth property and execute `./jupyter.helm-update.sh` again.

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
