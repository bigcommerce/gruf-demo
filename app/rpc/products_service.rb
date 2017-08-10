require_relative 'app/proto/Products_services_pb'


class ProductsService < Rpc::Products::Service
  include Gruf::Service

  ##
  # @param [Demo::GetJobReq] req The incoming gRPC request object
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
end