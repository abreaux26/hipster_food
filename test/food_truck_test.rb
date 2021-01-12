require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'

class FoodTruckTest < Minitest::Test
  def setup
    @food_truck = FoodTruck.new('Rocky Mountain Pies')
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
  end

  def test_it_exists
    assert_instance_of FoodTruck, @food_truck
  end

  def test_it_has_readable_attributes
    assert_equal 'Rocky Mountain Pies', @food_truck.name
    expected = {}
    assert_equal expected, @food_truck.inventory
  end

  def test_check_stock
    assert_equal 0, @food_truck.check_stock(@item1)
  end

  def test_stock
    @food_truck.stock(@item1, 30)
    expected = { @item1 => 30 }
    assert_equal expected, @food_truck.inventory
    assert_equal 30, @food_truck.check_stock(@item1)
  end
end
