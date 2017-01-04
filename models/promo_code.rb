class PromoCode
  attr_reader :text

  def initialize(text, discount)
    @text = text
    @discount = (100-discount.to_f) / 100
  end

  def apply(line_item)
    line_item.price * @discount
  end
end