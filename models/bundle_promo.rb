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