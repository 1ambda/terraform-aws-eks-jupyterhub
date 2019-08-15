# k8s-jupyter-hub

## Preparation 

- [x] `k8s.efs-volume.yaml` 파일 내의 `{EFS-ID}` 값을 수정

```bash
# Jupyter Hub 를 위한 EBS, EFS k8s 리소스를 생성 
./jupyter.helm-prepare.sh
```

## Installation

`jupyter.helm-config.yaml` 파일 내의 다음 값들을 수정

- [ ] `secretToken`
- [x] `service.beta.kubernetes.io/aws-load-balancer-extra-security-groups`

```bash
# jupyterhub helm chart 설치
./jupyter.helm-install.sh

# jupyter hub pod 들이 생성되고 있는지 확인 
kubectl get pods -n jupyter-production -w
```

## Update 

jupyter hub helm chart 를 업데이트 하려면 아래의 커맨드를 실행합니다. 

```bash
./jupyter.helm-update.sh
```

## Setup Github OAuth

- [x] [Github Secret for OAuth Authentication](https://github.com/settings/apps) 생성 
- [x] [Github Secret for Jupyterhub Authentication](https://zero-to-jupyterhub.readthedocs.io/en/latest/authentication.html) 설정 참고 
- [x] `jupyter.helm-config.yaml` 파일 내의 `auth.type` and `auth.github` 값 수정 

```bash
./jupyter.helm-update.sh
```
