# frozen_string_literal: true

##
# Represents a product service that is used for illustrating server calls
#
class ProductsController < Gruf::Controllers::Base
  bind ::Rpc::Products::Service

  def initialize(*args)
    @received_products = Hash.new { |h, k| h[k] = [] }
    super
  end

  ##
  # Illustrates a request and response call
  #
  # @return [Rpc::GetProductResp] The response
  #
  def get_product
    product = ::Product.find(request.message.id.to_i)

    Rpc::GetProductResp.new(
      product: Rpc::Product.new(
        id: product.id,
        name: product.name,
        price: product.price
      )
    )
  rescue
    fail!(:not_found, :product_not_found, "Failed to find Product with ID: #{request.message.id}")
  end

  ##
  # Illustrates a server streaming call
  #
  # @return [Rpc::Product] An enumerable of Products that is streamed
  #
  def get_products
    return enum_for(:get_products) unless block_given?

    q = ::Product
    q = q.where('name LIKE ?', "%#{request.message.search}%") if request.message.search.present?
    limit = request.message.limit.to_i.positive? ? request.message.limit : 100
    q.limit(limit).each do |product|
      sleep(rand(0.01..0.3))
      yield product.to_proto
    end
  rescue StandardError => e
    fail!(:internal, :unknown, "Unknown error when listing Products: #{e.message}")
  end

  ##
  # Illustrates a client streaming call
  #
  # @return [Rpc::CreateProductsResp]
  #
  def create_products
    products = []
    request.messages do |message|
      products << Product.new(name: message.name, price: message.price).to_proto
    end
    Rpc::CreateProductsResp.new(products: products)
  end

  ##
  # @return [Enumerable<Rpc::Product>]
  #
  def create_products_in_stream
    return enum_for(:create_products_in_stream) unless block_given?

    request.messages.each do |r|
      sleep(rand(0.01..0.3))
      yield Product.new(name: r.name, price: r.price).to_proto
    end
  end
end
