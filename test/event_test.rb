require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'
require './lib/event'

class EventTest < Minitest::Test
  def setup
    @event = Event.new('South Pearl Street Farmers Market')
    @food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    @food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    @food_truck3 = FoodTruck.new('Palisade Peach Shack')

    @item1 = Item.new({name: 'Peach Pie (Slice)', price: '$3.75'})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    @item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})

    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
  end

  def add_trucks_to_event
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
  end

  def test_it_exists
    assert_instance_of Event, @event
  end

  def test_it_has_readable_attributes
    assert_equal 'South Pearl Street Farmers Market', @event.name
    assert_equal [], @event.food_trucks
  end

  def test_add_food_truck
    @event.add_food_truck(@food_truck1)

    assert_equal [@food_truck1], @event.food_trucks
  end

  def test_food_truck_names
    @event.add_food_truck(@food_truck1)

    assert_equal ['Rocky Mountain Pies'], @event.food_truck_names
  end

  def test_food_trucks_that_sell
    add_trucks_to_event

    expected = [@food_truck1, @food_truck3]

    assert_equal expected, @event.food_trucks_that_sell(@item1)
  end

  def test_sorted_item_list
    add_trucks_to_event

    expected = [
      'Apple Pie (Slice)',
      'Banana Nice Cream',
      'Peach Pie (Slice)',
      'Peach-Raspberry Nice Cream'
    ]

    assert_equal expected, @event.sorted_item_list
  end

  def test_item_names_per_food_truck
    add_trucks_to_event

    expected = [
      'Apple Pie (Slice)',
      'Peach Pie (Slice)',
      'Banana Nice Cream',
      'Peach-Raspberry Nice Cream'
    ]

    assert_equal expected, @event.item_names_per_food_truck
  end

  def test_overstocked_items
    add_trucks_to_event

    assert_equal [@item1], @event.overstocked_items
  end

  def test_food_trucks_per_item
    add_trucks_to_event

    expected = {
      @item1 => [@food_truck1, @food_truck3],
      @item2 => [@food_truck1],
      @item3 => [@food_truck2],
      @item4 => [@food_truck2]
    }

    assert_equal expected, @event.food_trucks_per_item
  end

  def test_overstocked
    add_trucks_to_event

    assert_equal true, @event.overstocked?(@item1, [@food_truck1, @food_truck3])
  end

  def test_list_of_items
    add_trucks_to_event

    assert_equal [@item1, @item2, @item4, @item3], @event.list_of_items
  end

  def test_total_inventory
    add_trucks_to_event

    expected = {
      @item1 => { quantity: 100, food_trucks: [@food_truck1, @food_truck3]},
      @item2 => { quantity: 7, food_trucks: [@food_truck1] },
      @item3 => { quantity: 25, food_trucks: [@food_truck2] },
      @item4 => { quantity: 50, food_trucks: [@food_truck2] }
    }

    assert_equal expected, @event.total_inventory
  end

  def test_quantity_per_item
    add_trucks_to_event

    assert_equal 100, @event.quantity_per_item(@item1)
  end
end
