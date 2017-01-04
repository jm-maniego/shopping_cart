class LineItem
  attr_reader :product
  attr_accessor :quantity, :price

  def initialize(product)
    @product = product
    @quantity = 1
    @price = original_price
  end

  def original_price
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
