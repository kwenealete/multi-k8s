docker build -t kalvete/complexcalc-client:latest -t kalvete/complexcalc-client:$SHA -f ./client/Dockerfile ./client
docker build -t kalvete/complexcalc-server:latest -t kalvete/complexcalc-server:$SHA -f ./server/Dockerfile ./server
docker build -t kalvete/complexcalc-worker:latest -t kalvete/complexcalc-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kalvete/complexcalc-client:latest
docker push kalvete/complexcalc-server:latest
docker push kalvete/complexcalc-worker:latest

docker push kalvete/complexcalc-client:$SHA
docker push kalvete/complexcalc-server:$SHA
docker push kalvete/complexcalc-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kalvete/complexcalc-server:$SHA
kubectl set image deployments/client-deployment client=kalvete/complexcalc-client:$SHA
kubectl set image deployments/worker-deployment worker=kalvete/complexcalc-worker:$SHA