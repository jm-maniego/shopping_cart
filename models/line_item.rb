class LineItem
  attr_reader :product
  attr_accessor :quantity

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def price
    @quantity * @product.price
  end
end
