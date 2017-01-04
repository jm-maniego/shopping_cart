require './models/line_item'
require './models/product'
require './models/promo_code'
require './models/promo'
require './models/pricing_rule'
require './lib/promo_code/promo_code_validator'
require './lib/pricing_rules/n_for_n_pricing_rule'
require './lib/pricing_rules/bulk_discount_pricing_rule'
require 'bigdecimal'
require './models/product_collection'

class ShoppingCart
  def initialize(pricing_rules)
    @promo = Promo.new(pricing_rules)
    @items_by_code = {}
    @promo_code_validator = PromoCodeValidator.new
    @bundle_promo = BundlePromo.new
    @promo_code_validator.add('I<3AMAYSIM', 10)
    @bundle_promo.add('ult_medium', '1gb')
  end

  def add(product, promo_code_text=nil)
    product_code = product.code
    line_item = find_or_new_line_item(product)
    line_item.quantity += 1

    if @promo_code_validator.valid?(promo_code_text)
      @promo.add(@promo_code_validator.get_promo_code(promo_code_text))
    end

    @bundle_promo.apply(product.code) do |new_item|
      @items_by_code[new_item.product.code] = new_item
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

  private
    def find_or_new_line_item(product)
      @items_by_code[product.code] ||= LineItem.new(product)
    end
end

class BundlePromo
  def initialize
    @every_product_add_code_pair = {}
  end

  def add(every_product_code, add_product_code)
    @every_product_add_code_pair[every_product_code] = add_product_code
  end

  def apply(every_product_code)
    if (add_product_code = @every_product_add_code_pair[every_product_code])
      new_product = ProductCollection.get(add_product_code)
      yield LineItem.new(new_product, {quantity: 1, free: true})
    end
  end
end