#!/bin/bash
set -e

#Install Prometheus and Grafana using Helm

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
helm install prometheus \
  prometheus-community/prometheus \
  -n monitoring \
  -f prom_values.yaml



#Install Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install grafana \
  grafana/grafana \
  -n monitoring \
  --set adminPassword=admin123 \
  --set service.type=LoadBalancer \
  --set resources.requests.cpu=50m \
  --set resources.requests.memory=128Mi \
  --set resources.limits.cpu=200m \
  --set resources.limits.memory=256Mi


