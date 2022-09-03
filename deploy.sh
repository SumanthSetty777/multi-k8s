docker build -t sumanthsetty/multi-client:latest -t sumanthsetty/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sumanthsetty/multi-server:latest -t sumanthsetty/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sumanthsetty/multi-worker:latest -t sumanthsetty/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sumanthsetty/multi-client:latest 
docker push sumanthsetty/multi-server:latest
docker push sumanthsetty/multi-worker:latest

docker push sumanthsetty/multi-client:$SHA
docker push sumanthsetty/multi-server:$SHA
docker push sumanthsetty/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sumanthsetty/multi-server:$SHA
kubectl set image deployment/client-deployment client=sumanthsetty/multi-server:$SHA
kubectln set image deployment/worker-deploment worker=sumanthsetty/multi-worker:$SHA

# docker tag local-image:tagname new-repo:tagname
# docker push new-repo:tagname