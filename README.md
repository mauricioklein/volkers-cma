# Volders CMA

Volders CMA is a small set of Volders's contract management api.

## Technologies

- Ruby 2.5.0
- Rails 5.0.1
- Postgresql 10.1

## Setup

The easiest way to setup the project is using Docker.

In this project, you can find the following files:
- **Dockerfile**: responsible to create the Docker image for the API;
- **docker-compose.yml**: setup the whole environment (API + database), linking them automatically.

By default, the API container exposes the port `3000`, which can be connected to a localhost port (more info below).

### Starting the environment

```bash
# Download the necessary Docker images
$ docker-compose pull

# Build the application image
$ docker-compose build app

# Start the environment, opening a bash terminal on the application container
$ docker-compose run --rm -p 3000:3000 app bash
```

This command will:
- Create the Docker image for the API
- Download the Postgresql image from Docker Registry
- Start the environment
- Connect API container port 3000 to localhost:3000
- Open a bash terminal into the API container

### Preparation

```bash
# Install the necessary gems
$ bundle install

# Prepare the database
$ rake db:setup
```

### Run the specs

This project is fully covered by automated tests, using Rspec:

```bash
# Run the specs
$ bundle exec rspec
```

### Start the server

```bash
$ rails s --port 3000 --binding 0.0.0.0
```

The API is now accessible on _http://localhost:3000/_.

## Usage

### Create a new user

Request:
```bash
$ curl -XPOST -H "Content-Type: application/json" -d '
{
        "user":{
                "full_name": "Peter Parker",
                "email": "peter@parker.com",
                "password": "12345678"
        }
}' http://localhost:3000/users
```

Response:
```json
{
  "id":1,
  "full_name":"Peter Parker",
  "email":"peter@parker.com"
}
```

### Login

Request:
```bash
$ curl -XPOST -H "Content-Type: application/json" -d '
{
        "user":{
                "email": "peter@parker.com",
                "password": "12345678"
        }
}' http://localhost:3000/users/login
```

Response:
```json
{
  "token":"7b20b13f2e5614424ddfc3e5bda502ef"
}
```

### Logout

Request:
```bash
$ curl -XPOST -H "Content-Type: application/json" -H "TOKEN: [Access token]" http://localhost:3000/users/logout
```

Response:
```bash
HTTP Status: 200 (OK)
```

### Create contract

Request:
```bash
$ curl -XPOST -H "Content-Type: application/json" -H "TOKEN: [Access token]" -d '
{
        "contract": {
                "vendor": "Vodafone",
                "price": "29.99",
                "starts_on": "2017-03-01",
                "ends_on": "2017-06-01"
        }
}' http://localhost:3000/contracts
```

Response:
```json
{
  "id":1,
  "vendor":"Vodafone",
  "starts_on":"2017-03-01",
  "ends_on":"2017-06-01",
  "price":29.99,
  "user_id":1,
  "created_at":"2018-01-04T12:44:00.457Z",
  "updated_at":"2018-01-04T12:44:00.457Z"
}
```

### Retrieve contracts

Request:
```bash
$ curl -XGET -H "Content-Type: application/json" -H "TOKEN: [Access token]" http://localhost:3000/contracts/1
```

Response:
```json
{
  "id":1,
  "vendor":"Vodafone",
  "starts_on":"2017-03-01",
  "ends_on":"2017-06-01",
  "price":29.99,
  "user_id":1,
  "created_at":"2018-01-04T12:44:00.457Z",
  "updated_at":"2018-01-04T12:44:00.457Z"
}
```

### Delete contract

Request:
```bash
$ curl -XDELETE -H "Content-Type: application/json" -H "TOKEN: [Access token]" http://localhost:3000/contracts/1
```

Response:
```bash
HTTP Status: 200 (OK)
```
