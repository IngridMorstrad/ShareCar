class CarsController < ApplicationController
  def new
      @car = Car.new
  end
  
  def create
      @car = Car.new(car_params)
      if @car.save
          redirect_to(:action => 'edit', :id => @car.id)
      else
          render 'new'
      end
  end

  def edit
      @car = Car.find(params[:id])
  end

  def delete
  end

  private
  def car_params
      params.require(:car).permit(:make, :model, :year, :cost_per_mile)
  end
end
