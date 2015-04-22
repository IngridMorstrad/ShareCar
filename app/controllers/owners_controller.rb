class OwnersController < ApplicationController
  def new
      @owner = Owner.new
  end

  def create
      @owner = Owner.new(owner_params)
      if @owner.save
          redirect_to '#'
      else
          render 'new'
      end
  end

  private
  def owner_params
      params.require(:owner).permit(:user)
  end
end
