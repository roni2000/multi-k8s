docker build -t roni3233/multi-client:latest -t roni3233/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t roni3233/multi-server:latest -t roni3233/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t roni3233/multi-worker:latest -t roni3233/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push roni3233/multi-client:latest
docker push roni3233/multi-server:latest
docker push roni3233/multi-worker:latest

docker push roni3233/multi-client:$SHA
docker push roni3233/multi-server:$SHA
docker push roni3233/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=roni3233/multi-server:$SHA
kubectl set image deployments/client-deployment client=roni3233/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=roni3233/multi-worker:$SHA



