class Promo
  def initialize(rules)
    @rules = rules
  end

  def apply(line_item)
    result = @rules.inject(0) do |sum, rule|
      sum += rule.apply(line_item)
    end
    return line_item.original_price if result.zero?
    result
  end
end