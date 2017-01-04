class BulkDiscountPricingRule < PricingRule
  def initialize(product_code)
    @product_code = product_code
  end

  def calculate(line_item)
    (line_item.product.price - BigDecimal.new('5')) * line_item.quantity
  end

  def validate(line_item)
    line_item.quantity > 3
  end
end