docker build -t dthunn/multi-client-k8s:latest -t dthunn/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t dthunn/multi-server-k8s:latest -t dthunn/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t dthunn/multi-worker-k8s:latest -t dthunn/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push dthunn/multi-client-k8s:latest
docker push dthunn/multi-server-k8s:latest
docker push dthunn/multi-worker-k8s:latest

docker push dthunn/multi-client-k8s:$SHA
docker push dthunn/multi-server-k8s:$SHA
docker push dthunn/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl rollout restart deployment/server-deployment
kubectl rollout restart deployment/client-deployment
kubectl rollout restart deployment/worker-deployment