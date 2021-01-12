require 'minitest/autorun'
require 'minitest/pride'
require './lib/event'

class EventTest < Minitest::Test
  def setup
    @event = Event.new('South Pearl Street Farmers Market')
  end

  def test_it_exists
    assert_instance_of Event, @event
  end

  def test_it_has_readable_attributes
    assert_equal 'South Pearl Street Farmers Market', @event.name
    assert_equal [], @event.food_trucks
  end
end
