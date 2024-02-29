# start minikube
minikube start

# create a deployment
minikube kubectl -- create deployment hello-node --image=kicbase/echo-server:1.0

# expose the deploymet
minikube kubectl -- expose deployment hello-node --type=LoadBalancer --port=8080

# service the deployment to show the app response
minikube service hello-node