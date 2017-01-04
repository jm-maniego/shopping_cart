class Product
  attr_reader :code, :name, :price

  def initialize(code, name, price)
    @code, @name, @price = code, name, BigDecimal.new(price)
  end
end
