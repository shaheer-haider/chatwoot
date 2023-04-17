#

## Build Image
~~~~
docker-compose build
~~~~

#

## Prepare DB
~~~~
docker-compose run --rm rails bundle exec rails db:chatwoot_prepare

docker-compose -f docker-compose.production.yaml run --rm rails bundle exec rails db:chatwoot_prepare
~~~~

#

## Run the application
~~~~
docker-compose up
~~~~

#

#

## Run local database for testing
~~~~
docker run -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgres -p 5432:5432 -d postgres:12
~~~~