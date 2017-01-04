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

  def name
    @product.name
  end

  def attributes
    {
      quantity: @quantity,
      name:     name
    }
  end
end
