class LoansController < ApplicationController
  def index
      @loaned = Loan.where(borrower_id: current_user.id)
      @borrowed = Loan.where(lender_id: current_user.id)
      @lgroup = @loaned.group(:lender_id).sum(:amount)
      @bgroup = @borrowed.group(:borrower_id).sum(:amount)
      # TODO: Confirm if deleting a key while iterating is safe
      @bgroup.each do |k,v|
          if @lgroup.has_key? k
              if v > @lgroup[k]
                  # Adjust the borrowed amount since a smaller amount was "lent"
                  @bgroup[k] -= @lgroup[k]
                  @lgroup.delete(k)
              elsif v < @lgroup[k]
                  @lgroup[k] -= @bgroup[k]
                  @bgroup.delete(k)
              else
                  # Equal amount borrowed and lent
                  @bgroup.delete(k)
                  @lgroup.delete(k)
              end
          end
      end
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
