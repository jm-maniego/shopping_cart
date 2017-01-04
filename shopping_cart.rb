require './models/line_item'
require './models/product'
require './models/promo_code'
require './models/promo'
require './models/pricing_rule'
require './lib/promo_code/promo_code_validator'
require './lib/pricing_rules/n_for_n_pricing_rule'
require './lib/pricing_rules/bulk_discount_pricing_rule'
require 'bigdecimal'

class ShoppingCart
  def initialize(pricing_rules)
    @promo = Promo.new(pricing_rules)
    @items_by_code = {}
    @promo_code_validator = PromoCodeValidator.new
    @promo_code_validator.add('I<3AMAYSIM', 10)
  end

  def add(item, promo_code_text=nil)
    product_code = item.code
    if @promo_code_validator.valid?(promo_code_text)
      @promo.add(@promo_code_validator.get_promo_code(promo_code_text))
    end

    if (line_item = @items_by_code[product_code])
      line_item.quantity += 1
    else
      @items_by_code[product_code] = line_item = LineItem.new(item)
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