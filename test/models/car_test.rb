require 'test_helper'

class CarTest < ActiveSupport::TestCase

  def setup
    @car = Car.new(make: "Toyota", model: "Camry", year: 2005, seats: 4, cost_per_mile: 0.1)
  end

  test "should be valid" do
    assert @car.valid?
  end

  test "seats should be a number" do
    @car.seats = "apple"
    assert_not @car.valid?
  end

  test "cost per mile should be a number" do
    @car.cost_per_mile = "apple"
    assert_not @car.valid?
  end

  test "make should be present" do
    @car.make = " "
    assert_not @car.valid?
  end

  test "model should be present" do
    @car.model = " "
    assert_not @car.valid?
  end

  test "year should be present" do
    @car.year = " "
    assert_not @car.valid?
  end

  test "seats should be present" do
    @car.seats = " "
    assert_not @car.valid?
  end
  
  test "cost_per_mile should be present" do
    @car.cost_per_mile = nil
    assert_not @car.valid?
  end
end
