docker build -t pseemangal/multi-client:latest -t pseemangal/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t pseemangal/multi-server:latest -t pseemangal/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t pseemangal/multi-worker:latest -t pseemangal/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push pseemangal/multi-client:latest
docker push pseemangal/multi-client:$GIT_SHA
docker push pseemangal/multi-server:latest
docker push pseemangal/multi-server:$GIT_SHA
docker push pseemangal/multi-worker:latest
docker push pseemangal/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=pseemangal/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=pseemangal/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=pseemangal/multi-worker:$GIT_SHA