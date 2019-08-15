# k8s-jupyter-nbviewer

## 1. Create Jupyter Hub Token

Jupyter Hub 를 브라우저에서 방문해 (`{HUB_URL}/hub/token`) NbViewer 를 위한 토큰을 생성합니다.

## 2. Setup Jupyter Hub Helm Chart

`hub.extraConfig.services` `jupyter.helm-config.yaml` 파일 내의 `hub.extraConfig.services` 주석을 풀고 위에서 만든 토큰 값을 입력합니다. 
그리고 아래 커맨드를 실행합니다.

```bash
./jupyter.helm-install.sh
```

## 3. Deploy NBViewer

`k8s.nbviewer-deployment.yaml` 파일 내에서 아래 값들을 수정합니다.

- [x] `JUPYTERHUB_API_TOKEN`
- [x] `JUPYTERHUB_BASE_URL`

```bash
./nbviewer.deployment-install.sh
```

적용 후 NbViewer 를 브라우저에서 방문합니다
- `{HUB_URL}/services/nbviewer`