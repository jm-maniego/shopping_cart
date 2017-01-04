class LineItem
  attr_reader :product
  attr_accessor :quantity, :price, :free

  def initialize(product, attributes={})
    @product = product
    @quantity = attributes.fetch(:quantity, 0)
    @free = attributes.fetch(:free, false)
    @price = 0 if @free
  end

  def price
    @price ||= original_price
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
