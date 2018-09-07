require 'faker'

namespace :test do
  task :get_product, [:hostname, :id] => :environment do |_, args|
    client = test_grpc_build_client(args, id: 1)

    begin
      product = client.call(:GetProduct, id: args[:id].to_i)
      puts product.message.inspect
    rescue Gruf::Client::Error => e
      puts e.error.inspect
    end
  end

  task :get_products, [:hostname, :search, :limit] => :environment do |_, args|
    client = test_grpc_build_client(args, search: '', limit: 10)

    begin
      client_args = {
        limit: args[:limit].to_i
      }
      client_args[:search] = args[:search] if args[:search].to_s.present?
      product = client.call(:GetProducts, client_args)
      product.message.each do |p|
        puts p.inspect
      end
    rescue Gruf::Client::Error => e
      puts e.error.inspect
    end
  end

  task :create_products, [:hostname, :number] => :environment do |_, args|
    client = test_grpc_build_client(args, number: 3)

    begin
      products = []
      args[:number].to_i.times do
        products << Rpc::Product.new(
          name: Faker::Lorem.word,
          price: rand(10.00..99.00).to_f
        )
      end
      product = client.call(:CreateProducts, products)
      puts product.message.inspect
    rescue Gruf::Client::Error => e
      puts e.error.inspect
    end
  end

  task :create_products_in_stream, [:hostname, :number, :delay] => :environment do |_, args|
    client = test_grpc_build_client(args, number: 3, delay: 0.5)

    begin
      products = []
      args[:number].to_i.times do
        products << Rpc::Product.new(
          name: Faker::Lorem.word,
          price: rand(10.00..99.00).to_f
        )
      end
      enumerator = Rpc::ProductRequestEnumerator.new(products, args[:delay].to_f)
      client.call(:CreateProductsInStream, enumerator.each_item) do |r|
        puts "Received response: #{r.inspect}"
      end

    rescue Gruf::Client::Error => e
      puts e.error.inspect
    end
  end

  ##
  # @param [Rake::TaskArguments] args
  # @param [Hash] defaults
  # @return [Gruf::Client]
  #
  def test_grpc_build_client(args, defaults = {})
    args.with_defaults(defaults.merge(
      hostname: '0.0.0.0:9000',
      password: 'austin',
    ))
    Gruf::Client.new(service: ::Rpc::Products, options: {
      hostname: args[:hostname],
      username: 'test',
      password: args[:password],
      client_options: {
        timeout: 10
      }
    })
  end
end
