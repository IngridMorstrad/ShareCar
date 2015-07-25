class LoansController < ApplicationController

  def index
    @loaned = Loan.where(borrower_id: current_user.id)
    @borrowed = Loan.where(lender_id: current_user.id)
    @lgroup = @loaned.group(:lender_id).sum(:amount)
    @bgroup = @borrowed.group(:borrower_id).sum(:amount)
    @bgroup.each do |k,v|
        if @lgroup.has_key? k
            if v > @lgroup[k]
                # Adjust the borrowed amount since a smaller amount was "lent"
                @bgroup[k] -= @lgroup[k]
                @lgroup[k] = 0
            elsif v < @lgroup[k]
                @lgroup[k] -= @bgroup[k]
                @bgroup[k] = 0
            else
                # Equal amount borrowed and lent
                @bgroup[k] = 0
                @lgroup[k] = 0
            end
        end
    end
    @bgroup.delete_if { |k, v| v == 0 }
    @lgroup.delete_if { |k, v| v == 0 }
  end

  def show
  end

  def new
    @loan = Loan.new
  end

  def create_multiple
    @trip = Trip.find(params[:trip_id])
    @trip.completed = true
    @trip.save
    owners = Owner.where(car_id: @trip.car_id).pluck(:user_id)
    passengers = Passenger.where(trip_id: @trip.id).where('user_id != ?', owners).pluck(:user_id)
    num_owners = owners.length
    num_passengers = passengers.length
    cost = num_passengers > 0 ? @trip.total_trip_cost/(num_owners*num_passengers) : 0
    owners.each do |o|
      passengers.each do |p|
        Loan.create(borrower_id: p, lender_id: o, trip_id: @trip.id, amount: cost/(num_passengers*num_owners))
      end
    end
    redirect_to loans_path
  end

  def edit
  end

  def delete
    user = User.find(params[:id])
    Loan.destroy_all(borrower_id: current_user.id, lender_id: user.id)
    Loan.destroy_all(borrower_id: user.id, lender_id: current_user.id)
    flash[:notice] = "Transaction completed."
    redirect_to loans_path
  end

  private

  def loan_params
    params.require(:loan).permit(:borrower,:lender,:amount)
  end
end
