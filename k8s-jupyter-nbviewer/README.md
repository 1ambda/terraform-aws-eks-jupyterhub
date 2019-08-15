# k8s-jupyter-nbviewer

## 1. Create Jupyter Hub Token

Jupyter Hub 를 브라우저에서 방문해 (`{HUB_URL}/hub/token`) and create a new token for the NbViewer service.
Go to `{HUB_URL}/hub/token` and create a new token for the NbViewer service.

## 2. Setup Jupyter Hub Helm Chart

Comment out `hub.extraConfig.services` in `jupyter.helm-config.yaml` and put the token value.
Then, apply it. 

```bash
./jupyter.helm-install.sh
```

## 3. Deploy NBViewer

Configure these values in `k8s.nbviewer-deployment.yaml`

- [x] `JUPYTERHUB_API_TOKEN`
- [x] `JUPYTERHUB_BASE_URL`

```bash
./nbviewer.deployment-install.sh
```

Then, visit NbViewer service
- `{HUB_URL}/services/nbviewer`