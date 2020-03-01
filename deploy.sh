docker build -t tpechacek/multi-client:latest -t tpechacek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tpechacek/multi-server:latest -t tpechacek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tpechacek/multi-worker:latest -t tpechacek/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tpechacek/multi-client:latest
docker push tpechacek/multi-server:latest
docker push tpechacek/multi-worker:latest

docker push tpechacek/multi-client:$SHA
docker push tpechacek/multi-server:$SHA
docker push tpechacek/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tpechacek/multi-server:$SHA
kubectl set image deployments/client-deployment client=tpechacek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tpechacek/multi-worker:$SHA