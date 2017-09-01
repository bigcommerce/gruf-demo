module Rpc
  class ProductRequestEnumerator
    def initialize(products, delay = 0.5)
      @products = products
      @delay = delay.to_f
    end

    def each_item
      return enum_for(:each_item) unless block_given?
      @products.each do |product|
        sleep @delay
        puts "Next product to send is #{product.inspect}"
        yield product
      end
    end
  end
end
