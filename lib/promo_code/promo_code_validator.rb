class PromoCodeValidator
  def initialize
    @valid_promo_codes_by_text = {}
  end

  def add(promo_code_text, discount)
    @valid_promo_codes_by_text[promo_code_text] = PromoCode.new(promo_code_text, discount)
  end

  def get_promo_code(promo_code_text)
    @valid_promo_codes_by_text[promo_code_text]
  end

  def valid?(promo_code_text)
    !@valid_promo_codes_by_text[promo_code_text].nil?
  end
end