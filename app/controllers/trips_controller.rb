class TripsController < ApplicationController
  before_action :is_passenger, only: [:decrement, :edit, :update, :destroy]
  before_action :is_owner, only: [:edit, :destroy]

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
    #@cars is a list of all the cars that current_user owns
    @cars = Owner.where(user_id: current_user.id).collect{ |o| [Car.find(o.car_id).human_name, o.car_id] }
    @url = trips_new_url
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      Passenger.create(user_id: current_user.id, trip_id: @trip.id)
      flash[:success] = "Successfully created trip!"
      redirect_to trips_path
    else
      flash.now[:error] = "Something went wrong...."
      render "new"
    end
  end

  def edit
    @trip = Trip.find(params[:id])
    #@cars is a list of all the cars that current_user owns which have atleast as many seats as passengers in @trip
    @cars = Owner.where(user_id: current_user.id, car_id: Car.where('seats >= ?', Passenger.where(trip_id: @trip.id).count).pluck(:id)).collect{ |o| [Car.find(o.car_id).human_name, o.car_id] }
    @url = trip_url
  end

  def update
    trip = Trip.find(params[:id])
    if trip.update_attributes(trip_params)
      flash[:success] = "Trip updated successfully!"
      redirect_to details_trip_path(trip)
    else
      flash[:error] = "Something went wrong in updating trip details."
      redirect_to trips_path
    end
  end

  ## TODO: Change name to something more meaningful
  ## TODO: If possible refactor this & decrement into one function
  def increment
    @trip = Trip.find(params[:id])
    #Now adding the record corresponding to (trip_id,user_id) to passengers table
    @passenger = Passenger.new(trip_id: @trip.id, user_id: current_user.id)
    if @passenger.save and @trip.save
      flash[:success] = "You've successfully joined this trip"
      redirect_to details_trip_path(@trip)
    else
      flash[:error] = "Failed to add passenger to trip"
      redirect_to trips_path
    end
  end

  def decrement
    @trip = Trip.find(params[:id])
    #Now removing the record corresponding to (trip_id,user_id) from passengers table
    passenger = Passenger.where(trip_id: @trip.id, user_id: current_user.id).first
    if passenger.destroy and @trip.save
      flash[:success] = "You've successfully left this trip"
      redirect_to details_trip_path(@trip)
    else
      flash[:error] = "Failed to remove passenger from trip"
      redirect_to trips_path
    end
  end

  def delete
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    flash[:notice] = "Trip cancelled!"
    redirect_to trips_path
  end

  private
  def trip_params
    params.require(:trip).permit(:distance, :car_id, :origin, :destination, :end_time, :start_time, :new_passenger_cost)
  end

  def is_passenger
    unless Passenger.where(trip_id: params[:id], user_id: current_user.id).present?
      flash[:error] = "You aren't on that trip"
      redirect_to trips_path
    end
  end

  def is_owner
    unless Owner.where(car_id: Trip.find(params[:id]).car_id, user_id: current_user.id).present?
      flash[:error] = "You don't own that trip"
      redirect_to trips_path
    end
  end
end
