docker build -t pawanpoudel/multi-client:latest -t pawanpoudel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pawanpoudel/multi-server:latest -t pawanpoudel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pawanpoudel/multi-worker:latest -t pawanpoudel/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pawanpoudel/multi-client:latest
docker push pawanpoudel/multi-server:latest
docker push pawanpoudel/multi-worker:latest

docker push pawanpoudel/multi-client:$SHA
docker push pawanpoudel/multi-server:$SHA
docker push pawanpoudel/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=pawanpoudel/multi-client:$SHA
kubectl set image deployments/server-deployment server=pawanpoudel/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pawanpoudel/multi-worker:$SHA
