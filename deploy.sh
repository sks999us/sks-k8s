docker build -t sks999us/sks-client:latest -t sks999us/sks-client:$SHA -f ./client/Dockerfile ./client
docker build -t sks999us/sks-server:latest -t sks999us/sks-client:$SHA  -f ./server/Dockerfile ./server
docker build -t sks999us/sks-worker:latest -t sks999us/sks-client:$SHA  -f ./worker/Dockerfile ./worker

docker push sks999us/sks-client:latest
docker push sks999us/sks-server:latest
docker push sks999us/sks-worker:latest

docker push sks999us/sks-client:$SHA 
docker push sks999us/sks-server:$SHA 
docker push sks999us/sks-worker:$SHA 

kubectl apply -f k8
kubectl set image deployments/client-deployment client=sks999us/sks-client:$SHA 
kubectl set image deployments/server-deployment server=sks999us/sks-server:$SHA 
kubectl set image deployments/worker-deployment worker=sks999us/sks-worker:$SHA 