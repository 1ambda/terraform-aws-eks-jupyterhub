# k8s-system-reloader

```bash
kubectl create namespace jupyter-production
helm repo add stakater https://stakater.github.io/stakater-charts
helm repo update
helm install stakater/reloader --set reloader.watchGlobally=false --namespace jupyter-production
```

- https://github.com/stakater/Reloader