class TripsController < ApplicationController
  before_action :is_passenger, only: [:show, :decrement, :edit, :update, :delete]
  before_action :is_owner, only: [:edit, :update, :delete]

  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
    @car = Car.find(@trip.car_id)
    @num_passengers = (Passenger.where(trip_id: @trip.id).collect {|p| User.find(p.user_id)}).length

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
    @trip.completed = false
    if @trip.save
      passenger = Passenger.new(user: current_user, trip: @trip)
      passenger.save
      redirect_to trips_path
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
      redirect_to trips_path
    end
  end

  ## TODO: Change name to something more meaningful
  ## TODO: If possible refactor this & decrement into one function
  def increment
    @trip = Trip.find(params[:trip][:id])
    #Now adding the record corresponding to (trip_id,user_id) to passengers table
    @passenger = Passenger.new(trip_id: @trip.id, user_id: current_user.id)
    if @passenger.save and @trip.update_attributes(trip_params)
      flash[:info] = ""
      redirect_to details_trip_path(@trip)
    else
      flash[:danger] = "Failed to add passenger to trip"
      redirect_to trips_path
    end
  end

  def decrement
    @trip = Trip.find(params[:trip][:id])
    #Now removing the record corresponding to (trip_id,user_id) from passengers table
    passenger = Passenger.where(trip_id: @trip.id, user_id: current_user.id).first
    if passenger.destroy and @trip.update_attributes(trip_params)
      flash[:info] = ""
      redirect_to details_trip_path(@trip)
    else
      flash[:danger] = "Failed to remove passenger from trip"
      redirect_to trips_path
    end
  end


  def delete
  end

  private
  def trip_params
    params.require(:trip).permit(:distance, :car_id, :origin, :destination, :end_time, :start_time, :new_passenger_cost)
  end

  def is_passenger
    unless Passenger.where(trip_id: params[:id], user_id: current_user.id).present?
      flash[:warning] = "You aren't on that trip"
      redirect_to trips_path
    end
  end

  def is_owner
    unless Owner.where(car_id: Trip.find(params[:id]).car_id, user_id: current_user.id).present?
      flash[:warning] = "You don't own that trip"
      redirect_to trips_path
    end
  end
end
