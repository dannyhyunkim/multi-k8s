docker build -t dannyhyunkim/multi-client:latest -t dannyhyunkim/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dannyhyunkim/multi-server:latest -t dannyhyunkim/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dannyhyunkim/multi-worker:latest -t dannyhyunkim/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dannyhyunkim/multi-client:latest
docker push dannyhyunkim/multi-client:$SHA
docker push dannyhyunkim/multi-server:latest
docker push dannyhyunkim/multi-server:$SHA
docker push dannyhyunkim/multi-worker:latest
docker push dannyhyunkim/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dannyhyunkim/multi-server:$SHA
kubectl set image deployments/client-deployment client=dannyhyunkim/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dannyhyunkim/multi-worker:$SHA