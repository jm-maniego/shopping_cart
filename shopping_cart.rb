require './models/line_item'
require './models/product'
require './pricing_rules/promo'
require './pricing_rules/pricing_rule'
require './pricing_rules/n_for_n_pricing_rule'
require './pricing_rules/bulk_discount_pricing_rule'
require 'bigdecimal'

class ShoppingCart
  def initialize(pricing_rules)
    @promo = Promo.new(pricing_rules)
    @items_by_code = {}
  end

  def add(item, promo_code=nil)
    product_code = item.code
    if (line_item = @items_by_code[product_code])
      line_item.quantity += 1
    else
      @items_by_code[product_code] = LineItem.new(item)
    end
  end

  def total
    @items_by_code.inject(0) do |sum, (_product_code, item)|
      sum + @promo.apply(item)
    end.to_f
  end

  def items
    @items_by_code.values.each do |item|
      puts "%{quantity} x %{name}" % item.attributes
    end
  end
end