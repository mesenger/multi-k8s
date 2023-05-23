!#/bin/bash

docker build -t mesenger/multi-client:latest -t mesenger/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mesenger/multi-server:latest -t mesenger/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mesenger/multi-worker:latest -t mesenger/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mesenger/multi-client:latest
docker push mesenger/multi-server:latest
docker push mesenger/multi-worker:latest

docker push mesenger/multi-client:$SHA
docker push mesenger/multi-server:$SHA
docker push mesenger/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mesenger/multi-server:$SHA
kubectl set image deployments/client-deployment client=mesenger/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mesenger/multi-worker:$SHA
