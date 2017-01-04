class PricingRule
  def apply(line_item)
    if applicable?(line_item)
      if validate(line_item)
        return calculate(line_item)
      end
      return line_item.price
    end
    0
  end

  def validate(line_item)
    true
  end

  def calculate(line_item)
    raise 'not implemented'
  end

  def applicable?(line_item)
    line_item.product.code == @product_code
  end
end