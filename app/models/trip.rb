class Trip < ActiveRecord::Base
    has_one :car
    has_many :passenger
    before_save :round_distance
    validates :distance, presence: true, numericality: {greater_than: 0}
    validates :origin, :destination, :start_time, :end_time, presence: true
    validates :total_trip_cost, numericality: {greater_than: 0}
    validate :start_must_be_before_end_time

    def update_details
    	number_of_passengers = Passenger.where(trip_id: self.id).count
	    base_cost = Car.find(self.car_id).cost_per_mile * self.distance
	    total_trip_cost = -1
	    if number_of_passengers == 1
	      total_trip_cost = base_cost * 1.2
	    elsif number_of_passengers == 2 or number_of_passengers == 3
	      total_trip_cost = base_cost * 1.1
	    elsif number_of_passengers == 4
	      total_trip_cost = base_cost * 1.05
	    else
	      total_trip_cost = base_cost
	    end
	    new_passenger_costs = {1 => 1.1, 2 => 1.1, 3 => 1.05, 4 => 1.0}
	    new_passenger_cost = base_cost * new_passenger_costs[[4,number_of_passengers].min]/(number_of_passengers+1)
	    self.update_attributes(:total_trip_cost => total_trip_cost, :new_passenger_cost => new_passenger_cost)
    end

    private

    def round_distance
    	#Rounding to 2 decimal places
    	distance.round(2)
    end

    def start_must_be_before_end_time
    	return unless start_time and end_time
    	errors.add(:start_time, "must be before end time") unless
        	start_time < end_time
    end
end
