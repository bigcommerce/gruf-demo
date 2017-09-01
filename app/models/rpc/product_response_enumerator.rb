module Rpc
  class ProductResponseEnumerator
    def initialize(products, created_products, delay = 0.5)
      @products = products
      @created_products = created_products
      @delay = delay.to_f
    end

    def each_item
      Rails.logger.info "got to ProductResponseEnumerator.each_item"
      return enum_for(:each_item) unless block_given?

      begin
        @products.each do |req|
          earlier_requests = @created_products[req.name]
          @created_products[req.name] << req
          Rails.logger.info "Got request: #{req.inspect}"

          earlier_requests.each do |r|
            product = Product.new(name: r.name, price: r.price).to_proto
            sleep @delay
            Rails.logger.info "Sending back to client: #{product.inspect}"
            yield product
          end
        end
      rescue StandardError => e
        fail e # signal completion via an error
      end
    end
  end
end
