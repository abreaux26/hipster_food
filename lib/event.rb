class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map(&:name)
  end

  def food_trucks_that_sell(item)
    @food_trucks.select do |food_truck|
      food_truck.inventory_items.include? item
    end
  end

  def sorted_item_list
    item_names_per_food_truck.sort
  end

  def item_names_per_food_truck
    @food_trucks.flat_map(&:sorted_inventory_items).uniq
  end
end
