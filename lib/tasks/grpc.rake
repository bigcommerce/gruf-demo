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
      product.message.each do |product|
        puts product.inspect
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
    })
  end
end
