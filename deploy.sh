docker build -t italoferreira/multi-client:latest -t italoferreira/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t italoferreira/multi-server:latest -t italoferreira/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t italoferreira/multi-worker:latest -t italoferreira/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push italoferreira/multi-client:latest
docker push italoferreira/multi-server:latest
docker push italoferreira/multi-worker:latest
docker push italoferreira/multi-client:$SHA
docker push italoferreira/multi-server:$SHA
docker push italoferreira/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=italoferreira/multi-server:$SHA
kubectl set image deployments/client-deployment client=italoferreira/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=italoferreira/multi-worker:$SHA