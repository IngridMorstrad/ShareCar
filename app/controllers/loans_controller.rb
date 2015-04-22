class LoansController < ApplicationController
  def index
      @loans = Loan.all
  end

  def show
  end

  def new
      @loan = Loan.new
  end

  def create_multiple
      @trip = Trip.find(params[:trip_id])
      passengers = Passenger.where(trip_id: @trip.id).collect {|p| User.find(p.user_id)}
      owners = Owner.where(car_id: @trip.car_id).collect {|o| User.find(o.user_id)}
      num_passengers = passengers.length
      num_owners = owners.length
      cost = @trip.total_trip_cost
      owners.each do |o| 
          passengers.each do |p|
              if (p != o)
                  Loan.create(borrower: p, lender: o, amount: cost/(num_passengers*num_owners)) 
              end
          end
      end
      redirect_to trips_path
  end

  def edit
  end

  def delete
  end

  private
  def loan_params 
      params.require(:loan).permit(:borrower,:lender,:amount)
  end
end
