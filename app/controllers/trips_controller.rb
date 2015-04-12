class TripsController < ApplicationController
  def index
      @trips = Trip.all
  end

  def show
      @trip = Trip.find(params[:id])
  end

  def new
      @trip = Trip.new
  end

  def create 
      @trip = Trip.new(trip_params)
      @trip.total_trip_cost = @trip.base_cost
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
      params.require(:trip).permit(:distance, :number_of_passengers, :car_name,:origin,:destination, :end_time, :start_time,:base_cost)
  end
end
