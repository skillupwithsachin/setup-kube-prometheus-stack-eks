# Deployment Order

cd monitoring
./install.sh

cd ../python-metrics-app
docker build -t <repo>/python-metrics-app:latest .
docker push <repo>/python-metrics-app:latest

helm install python-metrics-app helm/python-metrics-app
