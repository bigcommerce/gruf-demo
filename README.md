# Gruf Demo Rails Application

This is a demo Rails application that utilizes [gruf](https://github.com/bigcommerce/gruf), a gRPC Ruby framework.

## Running

```bash
bundle install
bundle exec rake db:create
bundle exec rake db:seed
foreman start
``` 

Then to test in another console:

```bash
bundle exec rake test:get_product
```