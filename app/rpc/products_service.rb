require_relative 'app/proto/Products_services_pb'


class ProductsService < Rpc::Products::Service
  include Gruf::Service

  ##
  # @param [Rpc::GetProductReq] req The incoming gRPC request object
  # @param [GRPC::ActiveCall] call The gRPC active call instance
  # @return [Rpc::GetProductResp] The response
  #
  def get_product(req, call)
    product = ::Product.find(req.id.to_i)

    Rpc::GetProductResp.new(
      product: Rpc::Product.new(
        id: product.id,
        name: product.name,
        price: product.price
      )
    )
  rescue
    fail!(req, call, :not_found, :product_not_found, "Failed to find Product with ID: #{req.id}")
  end

  ##
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
end
