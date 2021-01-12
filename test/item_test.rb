require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
  end

  def test_it_exists
    assert_instance_of Item, @item1
  end

  def test_it_has_readable_attributes
    assert_equal 'Peach Pie (Slice)', @item1.name
    assert_equal 3.75, @item1.price
  end
end
