class ProductCollection
  def initialize
    @products_by_code = {}
    data.each do |code, name, price|
      add(Product.new(code, name, price))
    end
  end

  def self.instance
    @@instance
  end

  def data
    [
      ['ult_small', 'Unlimited 1GB', '24.90'],
      ['ult_medium', 'Unlimited 2GB', '29.90'],
      ['ult_large', 'Unlimited 5GB', '44.90'],
      ['1gb', '1 GB Data-pack', '9.90']
    ]
  end

  def add(product)
    @products_by_code[product.code] = product
  end

  @@instance = ProductCollection.new

  def get(product_code)
    @products_by_code[product_code]
  end

  def self.get(product_code)
    @@instance.get(product_code)
  end
end