class CarsController < ApplicationController
  before_action :owns_car, only: [:edit, :update, :destroy, :delete]

  def index
    @cars = Car.where(id: Owner.where(user_id: current_user.id).pluck(:car_id))
  end

  def new
    @car = Car.new
    @url = cars_url
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      @owner = Owner.new(car_id: @car.id, user_id: current_user.id)
      if @owner.save
        redirect_to cars_path
      else
        flash.now[:alert] = "Could not assign car ownership. Please try again."
        render 'new'
      end
    else
      flash.now[:alert] = "Could not save car. Please check the errors below."
      render 'new'
    end
  end

  def edit
    @car = Car.where(id: params[:id]).first
    @url = car_url
  end

  def update
    car = Car.where(id: params[:id]).first
    if car.update_attributes(car_params)
      flash[:success] = "Modified the details!"
    else
      flash[:alert] = "Could not update car details. Please check the details and try again."
    end
    redirect_to cars_path
  end

  def delete
    car = Car.where(id: params[:id]).first
    car.destroy
    flash[:notice] = "Car and all its owners forgotten."
    redirect_to cars_path
  end

  private
  def car_params
    params.require(:car).permit(:make, :model, :year, :cost_per_mile, :seats)
  end

  def owns_car
    unless Owner.where(car_id: params[:id], user_id: current_user.id).present?
      flash[:alert] = "You don't own such a car!"
      redirect_to trips_path
    end
  end

end
