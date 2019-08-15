# k8s-system-dashboard

## Installing Metric Server

```bash
kubectl apply -f metric-server-v0.3.3
```

## Installing Kubernetes Dashboard

```bash
kubectl delete ns kubernetes-dashboard
kubectl apply -f dashboard-v2.0.0-beta3/
```

Then, execute `kubectl proxy` in your terminal and visit the kubernetes dashboard URL
- http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/node?namespace=default
