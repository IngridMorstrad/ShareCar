class CarsController < ApplicationController
  before_action :owns_car, only: [:edit, :update, :destroy]
  before_action :is_user, only: [:new, :create]

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @owner = Owner.new(car: @car, user: current_user)
    if @car.save and @owner.save
      redirect_to root_path
    else
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
      flash[:notice] = "Illegal action"
      redirect_to(root_url)
    end
  end

  def is_user
    redirect_to(root_url) unless current_user
  end

end
