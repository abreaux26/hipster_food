require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'

class FoodTruckTest < Minitest::Test
  def setup
    @food_truck = FoodTruck.new('Rocky Mountain Pies')
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: '$3.75'})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists
    assert_instance_of FoodTruck, @food_truck
  end

  def test_it_has_readable_attributes
    assert_equal 'Rocky Mountain Pies', @food_truck.name
    expected = {}
    assert_equal expected, @food_truck.inventory
  end

  def test_check_stock_without_item_inventory
    assert_equal 0, @food_truck.check_stock(@item1)
  end

  def test_check_stock_with_item_inventory
    @food_truck.stock(@item1, 30)

    assert_equal 30, @food_truck.check_stock(@item1)
  end

  def test_stock
    @food_truck.stock(@item1, 30)

    expected = { @item1 => 30 }

    assert_equal expected, @food_truck.inventory
  end

  def test_add_num_of_stock_to_inventory_item
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)

    expected = { @item1 => 55 }
    assert_equal expected, @food_truck.inventory
  end

  def test_inventory_items
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)

    assert_equal [@item1], @food_truck.inventory_items
  end

  def test_potential_revenue
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)

    assert_equal 206.25, @food_truck.potential_revenue
  end

  def test_sorted_inventory_items
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)
    @food_truck.stock(@item2, 7)

    expected = [
      'Apple Pie (Slice)',
      'Peach Pie (Slice)'
    ]

    assert_equal expected, @food_truck.sorted_inventory_items
  end

  def test_inventory_items_names
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)
    @food_truck.stock(@item2, 7)

    expected = [
      'Peach Pie (Slice)',
      'Apple Pie (Slice)'
    ]

    assert_equal expected, @food_truck.inventory_items_names
  end

  def test_overstocked
    @food_truck.stock(@item1, 30)
    @food_truck.stock(@item1, 25)

    assert_equal true, @food_truck.overstocked?(@item1)
  end
end
