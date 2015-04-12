class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
        t.string :car_name, :origin, :destination
        t.datetime :start_time, :end_time
        t.decimal :distance, :base_cost, :total_trip_cost
        t.integer :number_of_passengers
      t.timestamps
    end
  end
end
