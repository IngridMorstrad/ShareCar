require 'test_helper'

class TripTest < ActiveSupport::TestCase

  def setup
    @trip = Trip.create(distance: 8, car_id: 1, origin: 'High point woods', destination: 'Epic', new_passenger_cost: 1.1/2*0.945, start_time: DateTime.new(2015,4,1,17), end_time: DateTime.new(2015,4,1,17,30), total_trip_cost: 0.945, completed: false)
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
