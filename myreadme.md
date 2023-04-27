#

## Build Image
~~~~
docker-compose build
~~~~

#

## Prepare DB
~~~~
docker-compose run --rm rails bundle exec rails db:chatwoot_prepare
docker compose run --rm rails bundle exec rails db:chatwoot_prepare

docker compose -f docker-compose.production.yaml run --rm rails bundle exec rails db:chatwoot_prepare
~~~~

#

## Run the application
~~~~
docker-compose up -e IMAGE_TAG=$IMAGE_TAG
~~~~

#

#

## Run local database for testing
~~~~
docker run -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgres -p 5432:5432 -d postgres:12
~~~~

Run docker of minikube
~~~~
eval $(minikube docker-env --shell bash)
~~~~

Authenticate Docker in AWS ECR
~~~~
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 454848198532.dkr.ecr.us-east-1.amazonaws.com
~~~~
Tag the image to Push in ECR
~~~~
docker tag alnafi_chatwoot:latest 454848198532.dkr.ecr.us-east-1.amazonaws.com/alnafi_chatwoot:latest
~~~~
Push in ECR
~~~~
docker push 454848198532.dkr.ecr.us-east-1.amazonaws.com/alnafi_chatwoot:latest
~~~~

Create Secret
~~~~
kubectl create secret generic ecr-key \
                                           --from-file=.dockerconfigjson=.docker/config.json \
                                           --type=kubernetes.io/dockerconfigjson
~~~~

## Docker Commands for ECR (it'll only work in bash)
#### Build
~~~~
docker build -f docker/Dockerfile -t alnafi_chatwoot:$(git rev-parse --short HEAD)
~~~~

#### Tag the image to push in ECR
~~~~
docker tag alnafi_chatwoot:$(git rev-parse --short HEAD) 454848198532.dkr.ecr.us-east-1.amazonaws.com/alnafi_chatwoot:$(git rev-parse --short HEAD)
~~~~


#### Push the image
~~~~
docker push 454848198532.dkr.ecr.us-east-1.amazonaws.com/alnafi_chatwoot:$(git rev-parse --short HEAD)
~~~~
