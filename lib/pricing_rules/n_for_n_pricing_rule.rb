class NForNPricingRule < PricingRule
  def initialize(n, for_n, product_code)
    @n, @for_n, @product_code = n, for_n, product_code
  end

  def calculate(line_item)
    product_price = line_item.product.price
    quantity = line_item.quantity
    result = product_price * ((quantity / @n) * @for_n)
    result += product_price * (quantity % @n)
    result
  end
end
