class Promo
  def initialize(rules)
    @rules = rules
  end

  def add(rule)
    @rules.push(rule)
  end

  def apply(line_item)
    result = @rules.inject(0) do |sum, rule|
      line_item.price = rule.apply(line_item)
      line_item.price
    end
    return line_item.original_price if result.zero?
    result
  end
end