class Product < ApplicationRecord
  validates_presence_of :name

  scope :with_name, ->(name) { where(name: name) }

  ##
  # @return [Rpc::Product]
  #
  def to_proto
    Rpc::Product.new(
      id: id.to_i,
      name: name.to_s,
      price: price.to_f
    )
  end
end
