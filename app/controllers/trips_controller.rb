class TripsController < ApplicationController
  before_action :is_passenger, only: [:decrement, :edit, :update, :delete]
  before_action :is_owner, only: [:edit, :delete]

  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
    @car = Car.find(@trip.car_id)
    @num_passengers = Passenger.where(trip_id: @trip.id).count
  end

  def new
    @trip = Trip.new
    @cars = Car.all
  end

  def create
    @trip = Trip.new(trip_params)
    base_cost = Car.find(@trip.car_id).cost_per_mile * @trip.distance
    @trip.assign_attributes(:total_trip_cost => base_cost * 1.2, :new_passenger_cost => base_cost * 1.1/2, :completed => false)
    if @trip.save
      Passenger.create(user_id: current_user.id, trip_id: @trip.id)
      flash[:success] = "Successfully created trip!"
      redirect_to trips_path
    else
      flash.now[:danger] = "Something went wrong in creating the trip."
      render 'new'
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update_details
      redirect_to details_trip_path(@trip)
    else
      flash[:danger] = "Something went wrong in updating trip details."
      redirect_to trips_path
    end
  end

  ## TODO: Change name to something more meaningful
  ## TODO: If possible refactor this & decrement into one function
  def increment
    @trip = Trip.find(params[:id])
    #Now adding the record corresponding to (trip_id,user_id) to passengers table
    @passenger = Passenger.new(trip_id: @trip.id, user_id: current_user.id)
    if @passenger.save and @trip.update_details
      flash[:success] = "You've successfully joined this trip"
      redirect_to details_trip_path(@trip)
    else
      flash[:danger] = "Failed to add passenger to trip"
      redirect_to trips_path
    end
  end

  def decrement
    @trip = Trip.find(params[:id])
    #Now removing the record corresponding to (trip_id,user_id) from passengers table
    passenger = Passenger.where(trip_id: @trip.id, user_id: current_user.id).first
    if passenger.destroy and @trip.update_details
      flash[:success] = "You've successfully left this trip"
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
