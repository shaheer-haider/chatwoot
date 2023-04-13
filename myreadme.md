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
docker run --name chatwoot-postgres -e POSTGRES_USER=nafi_chatwoot_user -e POSTGRES_PASSWORD=nafi_chatwoot_password -e POSTGRES_DB=nafi_chatwoot -p 5432:5432 -d postgres:12
~~~~