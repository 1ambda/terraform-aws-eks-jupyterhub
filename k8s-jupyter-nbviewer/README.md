# k8s-jupyter-nbviewer

- [x] Create `JUPYTERHUB_API_TOKEN` in Jupyter Hub Admin (`{HUB_URL}/hub/token`)
- [x] Modify `JUPYTERHUB_BASE_URL`
- [x] Comment out `hub.extraConfig.services` and put the created token
- [x] Apply jupyter hub chart

```bash
./nbviewer.deployment-install.sh
```

Visit `{HUB_URL}/services/nbviewer`