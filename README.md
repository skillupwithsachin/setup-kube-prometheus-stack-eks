# Deployment Order

cd monitoring
./install.sh

cd ../python-metrics-app
docker build -t <repo>/python-metrics-app:latest .
docker push <repo>/python-metrics-app:latest

helm install python-metrics-app helm/python-metrics-app


If you are getting the errors in deploying application:

Failed to pull image "amithy25/python-metrics-app:latest": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/amithy25/python-metrics-app:latest": no match for platform in manifest: not found. (29s)

Re build image using docker buildx.

docker buildx create --use
docker buildx inspect --bootstrap

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t <image-name> \
  --push .

docker buildx imagetools inspect <image-name>

Restart the pod:

kubectl delete pod -l app=python-metrics-app

