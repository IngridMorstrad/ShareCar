class PagesController < ApplicationController
  def index
      @loans = Loan.all
  end

  def show
  end

  def new
      @loan = Loan.new
  end

  def create
      @loan = Loan.new(loan_params)
      if @loan.save
          redirect_to(:action => 'index')
      else
          render 'new'
      end
  end

  def edit
  end

  def delete
  end

  private
  def loan_params 
      params.require(:loan).permit()
  end
end
