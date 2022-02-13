docker build -t dthunn/multi-client:latest -t dthunn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dthunn/multi-server:latest -t dthunn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dthunn/multi-worker:latest -t dthunn/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dthunn/multi-client:latest
docker push dthunn/multi-server:latest
docker push dthunn/multi-worker:latest

docker push dthunn/multi-client:$SHA
docker push dthunn/multi-server:$SHA
docker push dthunn/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dthunn/multi-server:$SHA
kubectl set image deployments/client-deployment client=dthunn/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dthunn/multi-worker:$SHA