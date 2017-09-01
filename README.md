# Gruf Demo Rails Application

This is a demo Rails application that utilizes [gruf](https://github.com/bigcommerce/gruf) 1.2.5+, a gRPC Ruby framework.

## Running

```bash
bundle install
bundle exec rake db:create
bundle exec rake db:seed
foreman start
``` 

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
