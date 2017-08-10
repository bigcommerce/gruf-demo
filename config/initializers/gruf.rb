require 'gruf'

Gruf.configure do |c|
  c.server_binding_url = Settings.grpc.server.url

  if Settings.grpc.server.tokens.to_s.present?
    c.authentication_options[:credentials] = Settings.grpc.server.tokens.to_s.split(',').map { |t| { password: t.strip } }
  end

  c.services = [ProductsService]
end

if Settings.grpc.server.tokens.to_s.present?
  Gruf::Authentication::Strategies.add(:basic, Gruf::Authentication::Basic)
end