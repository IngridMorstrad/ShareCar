require 'test_helper'

class TripTest < ActiveSupport::TestCase

  def setup
    @car = cars(:camry)
    @trip=Trip.create(origin:"A",destination:"B",car_id:@car.id,start_time:"9:00",end_time:"10:00",distance:200.0)
  end

  test "should be valid" do
    assert @trip.valid?
  end

  test "distance should be a number" do
    @trip.distance = "invalid"
    assert_not @trip.valid?
  end

  test "origin should be present" do
    @trip.origin = " "
    assert_not @trip.valid?
  end

  test "destination should be present" do
    @trip.destination = " "
    assert_not @trip.valid?
  end

  test "start time should be present" do
    @trip.start_time = ""
    assert_not @trip.valid?
  end

  test "end time should be present" do
    @trip.end_time = ""
    assert_not @trip.valid?
  end

end
