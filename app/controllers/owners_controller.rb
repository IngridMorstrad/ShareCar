class OwnersController < ApplicationController
  def new
      @owner = Owner.new
  end

  def create
      @owner = Owner.new(owner_params)
      if @owner.save
          flash[:success] = "Successfully created owner"
          redirect_to trips_path
      else
          flash.now[:alert] = "Couldn't create owner"
          render 'new'
      end
  end

  private
  def owner_params
      params.require(:owner).permit(:user_id, :car_id)
  end
end
