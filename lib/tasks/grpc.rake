namespace :test do
  task :get_product, [:hostname, :id] => :environment do |_, args|
    args.with_defaults(
      hostname: '0.0.0.0:9000',
      password: 'austin',
      id: 1
    )

    begin
      client = Gruf::Client.new(service: ::Rpc::Products, options: {
        hostname: args[:hostname],
        username: 'test',
        password: args[:password],
      })
      product = client.call(:GetProduct, id: args[:id].to_i)
      puts product.message.inspect
    rescue Gruf::Client::Error => e
      puts e.error.inspect
    end
  end
end