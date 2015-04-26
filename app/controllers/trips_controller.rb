class TripsController < ApplicationController
  def index
      if current_user
        @trips = Trip.all
      else
        redirect_to log_in_path
      end
  end

  def show
      @trip = Trip.find(params[:id])
  end

  def new
      @trip = Trip.new
      @cars = Car.all
  end

  def create 
      @trip = Trip.new(trip_params)
      base_cost = Car.find(@trip.car_id).cost_per_mile * @trip.distance
      @trip.total_trip_cost = base_cost * 1.2
      @trip.new_passenger_cost = base_cost * 1.1/2
      if @trip.save
          passenger = Passenger.new(user: current_user, trip: @trip)
          passenger.save
          redirect_to(:action => 'index')
      else
          render 'new'
      end
  end

  def edit
      @trip = Trip.find(params[:id])
  end
  
  def update
      @trip = Trip.find(params[:id])
      number_of_passengers = Passenger.where(trip_id: @trip.id).count
      base_cost = Car.find(@trip.car_id).cost_per_mile * @trip.distance
      if number_of_passengers == 1
          @trip.total_trip_cost = base_cost * 1.2
      elsif number_of_passengers == 2 or number_of_passengers == 3
          @trip.total_trip_cost = base_cost * 1.1
      elsif number_of_passengers == 4
          @trip.total_trip_cost = base_cost * 1.05
      else
          @trip.total_trip_cost = base_cost
      end
      new_passenger_costs = {1 => 1.1, 2 => 1.1, 3 => 1.05, 4 => 1.0}
      @trip.new_passenger_cost = base_cost * new_passenger_costs[min(4,number_of_passengers)]/(number_of_passengers+1)

      if @trip.update_attributes(trip_params)
          redirect_to(:action => 'show', :id => @trip.id)
      else
          render('index')
      end
  end

  def increment
    @trip = Trip.find(params[:trip][:id])
    #Now adding the record corresponding to (trip_id,user_id) to passengers table
    @passenger = Passenger.new(trip_id: @trip.id, user_id: current_user.id)
    if @passenger.save and @trip.update_attributes(trip_params)
      #redirect_to(:action => 'show', :id => @trip.id)
      redirect_to "/" #TODO: We'll change it back to the above once show is ready
    else
      redirect_to "/"
    end
  end

  def decrement
    @trip = Trip.find(params[:trip][:id])
    #Now removing the record corresponding to (trip_id,user_id) from passengers table
    passenger = Passenger.where(trip_id: @trip.id, user_id: current_user.id).first
    if passenger.destroy and @trip.update_attributes(trip_params)
      #redirect_to(:action => "show", :id => @trip.id)
      redirect_to "/" #TODO: We'll change it back to above once show is ready
    else
      redirect_to "/"
    end
  end


  def delete
  end

  private
  def trip_params
      params.require(:trip).permit(:distance, :car_id, :origin, :destination, :end_time, :start_time, :new_passenger_cost)
  end
end
