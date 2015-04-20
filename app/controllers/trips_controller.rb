class TripsController < ApplicationController
  def index
      if session[:user_id]
        @user = User.find(session[:user_id])
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
      if @trip.number_of_passengers == 1
          @trip.total_trip_cost = base_cost * 1.2
      elsif @trip.number_of_passengers ==2 or @trip.number_of_passengers == 3
          @trip.total_trip_cost = base_cost * 1.1
      elsif @trip.number_of_passengers == 4
          @trip.total_trip_cost = base_cost * 1.05
      else
          @trip.total_trip_cost = base_cost
      end
      @trip.base_cost = @trip.total_trip_cost/@trip.number_of_passengers
      if @trip.save
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
      if @trip.update_attributes(trip_params)
          redirect_to(:action => 'show', :id => @trip.id)
      else
          render('index')
      end
  end

  def increment
      @trip = Trip.find(params[:id])
      @trip.number_of_passengers += 1
      if @trip.update_attributes(trip_params)
          redirect_to(:action => 'show', :id => @trip.id)
      else
          render('index')
      end
  end


  def delete
  end

  private
  def trip_params
      params.require(:trip).permit(:distance, :number_of_passengers, :car_id,:origin,:destination, :end_time, :start_time,:base_cost)
  end
end
