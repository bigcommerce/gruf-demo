require_relative 'app/proto/Products_services_pb'

##
# Represents a product service that is used for illustrating server calls
#
class ProductsService < Rpc::Products::Service
  include Gruf::Service

  def initialize
    @received_products = Hash.new { |h, k| h[k] = [] }
  end

  ##
  # Illustrates a request and response call
  #
  # @param [Rpc::GetProductReq] req The incoming gRPC request object
  # @param [GRPC::ActiveCall] call The gRPC active call instance
  # @return [Rpc::GetProductResp] The response
  #
  def get_product(req, call)
    product = ::Product.find(req.id.to_i)

    #add_field_error(:name, :invalid_name, 'Invalid name!')
    #fail!(req, call, :internal, :boo, 'Failure!') if has_field_errors?
    #raise 'Oh no an exception!'

    Rpc::GetProductResp.new(
      product: Rpc::Product.new(
        id: product.id,
        name: product.name,
        price: product.price
      )
    )
  rescue ActiveRecord::ActiveRecordError
    fail!(req, call, :not_found, :product_not_found, "Failed to find Product with ID: #{req.id}")
  rescue => e
    set_debug_info(e.message, e.backtrace[0..4])
    fail!(req, call, :internal, :internal)
  end

  ##
  # Illustrates a server streaming call
  #
  # @param [Rpc::GetProductsReq] req The incoming gRPC request object
  # @param [GRPC::ActiveCall] call The gRPC active call instance
  # @return [Rpc::Product] An enumerable of Products that is streamed
  #
  def get_products(req, call)
    q = ::Product
    q = q.where('name LIKE ?', "%#{req.search}%") if req.search.present?
    limit = req.limit.to_i > 0 ? req.limit : 100
    products = q.limit(limit).all
    products.map(&:to_proto)
  rescue => e
    fail!(req, call, :internal, :unknown, "Unknown error when listing Products: #{e.message}")
  end

  ##
  # Illustrates a client streaming call
  #
  # @param [GRPC::ActiveCall] call
  # @return [Rpc::CreateProductsResp]
  #
  def create_products(call)
    products = []
    call.each_remote_read do |req|
      products << Product.new(name: req.name, price: req.price).to_proto
    end
    Rpc::CreateProductsResp.new(products: products)
  end

  ##
  # @param [Array<Rpc::Product>] requests
  # @param [GRPC::ActiveCall] _call
  # @return [Enumerable<Rpc::Product>]
  #
  def create_products_in_stream(requests, _call)
    products = []
    requests.each do |r|
      products << Product.new(name: r.name, price: r.price).to_proto
    end
    products
  end
end
