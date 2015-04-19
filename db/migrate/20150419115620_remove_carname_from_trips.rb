class RemoveCarnameFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :car_name, :string
  end
end
