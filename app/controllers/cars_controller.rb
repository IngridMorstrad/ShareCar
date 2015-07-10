class CarsController < ApplicationController
  before_action :owns_car, only: [:edit, :update, :destroy, :delete]

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      @owner = Owner.new(car_id: @car.id, user_id: current_user.id)
      if @owner.save
        redirect_to trips_path
      else
        flash.now[:danger] = "Error in saving owner!"
        render 'new'
      end
    else
      flash.now[:danger] = "Error in saving car!"
      render 'new'
    end
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])
    @car.save
  end

  def delete
  end

  private
  def car_params
    params.require(:car).permit(:make, :model, :year, :cost_per_mile, :seats)
  end

  def owns_car
    unless Owner.where(car_id: params[:id], user_id: current_user.id).present?
      flash[:danger] = "Illegal action"
      redirect_to trips_path
    end
  end

end
