require './shopping_cart'
require 'test-unit'

class ShoppingCartTest < Test::Unit::TestCase
  def setup
    @pricing_rules = []
    three4two_rule = NForNPricingRule.new(3, 2, 'ult_small')
    bulk_discount_rule = BulkDiscountPricingRule.new('ult_large')

    @pricing_rules.push(three4two_rule)
    @pricing_rules.push(bulk_discount_rule)

    @item1 = Product.new('ult_small', 'Unlimited 1GB', '24.90')
    @item2 = Product.new('ult_medium', 'Unlimited 2GB', '29.90')
    @item3 = Product.new('ult_large', 'Unlimited 5GB', '44.90')
    @item4 = Product.new('1gb', '1 GB Data-pack', '9.90')
  end

  test "scenario 1" do
    cart = ShoppingCart.new(@pricing_rules)
    3.times { cart.add(@item1) }
    cart.add(@item3)

    puts
    cart.items

    assert_equal 94.70, cart.total
  end

  test 'scenario 2' do
    cart = ShoppingCart.new(@pricing_rules)
    2.times { cart.add(@item1) }
    4.times { cart.add(@item3) }

    puts
    cart.items

    assert_equal 209.40, cart.total
  end

  test 'scenario 3' do
    cart = ShoppingCart.new(@pricing_rules)
    cart.add(@item1)
    2.times { cart.add(@item2) }

    puts
    cart.items

    assert_equal 84.70, cart.total
  end

  test 'scenario 4' do
    cart = ShoppingCart.new(@pricing_rules)
    cart.add(@item1)
    cart.add(@item4, 'I<3AMAYSIM')

    puts
    cart.items

    assert_equal 31.32, cart.total
  end
end