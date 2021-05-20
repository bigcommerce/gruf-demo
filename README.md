# Gruf Demo Rails Application

This is a demo Rails application that utilizes [gruf](https://github.com/bigcommerce/gruf) 2.1.0+, a gRPC Ruby framework.

This application is running Rails 6.1 in Ruby 3.0.

## Running

Set the database URL as a `DATABASE_URL` env var in a `.env` file, then:

```bash
bundle install
bundle exec rake db:create db:migrate
bundle exec rake db:seed
bundle exec gruf
``` 

Alternatively, you can run `./script/e2e` to automatically run a server and issue a set of different types
of requests against it.

## Testing with a Client

Then in another console, you can run provided rake tasks to see it in action.

### Request/Response (Get a Product)

```bash
bundle exec rake test:get_product
```

### Server Streamer (Get a list of Products)

```bash
bundle exec rake test:get_products
```

### Client Streamer (Create a list of Products)

```bash
bundle exec rake test:create_products
```

### Bidirectional Streamer (Create a list of Products and get back responses immediately in stream)

```bash
bundle exec rake test:create_products_in_stream
```

## In Docker

This repository is also setup to run in a Docker container with docker-compose:

```bash
docker-compose up
```

Then, find the port docker exposed, and in another terminal, you can demo with:

```
GRPC_SERVER_URL=IP_OF_YOUR_DOCKER_INSTANCE:PORT_THAT_WAS_EXPOSED bundle exec rake test:get_product
```

## License

Copyright (c) 2017-present, BigCommerce Pty. Ltd. All rights reserved 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the 
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the 
Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
