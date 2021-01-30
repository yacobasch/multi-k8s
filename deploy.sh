docker build -t yacaschdkr20/multi-client:latest -t yacaschdkr20/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yacaschdkr20/multi-server:latest -t yacaschdkr20/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yacaschdkr20/multi-worker:latest -t yacaschdkr20/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yacaschdkr20/multi-client:latest
docker push yacaschdkr20/multi-server:latest
docker push yacaschdkr20/multi-worker:latest

docker push yacaschdkr20/multi-client:$SHA
docker push yacaschdkr20/multi-server:$SHA
docker push yacaschdkr20/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=yacaschdkr20/multi-client:$SHA
kubectl set image deployment/server-deployment server=yacaschdkr20/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=yacaschdkr20/multi-worker:$SHA