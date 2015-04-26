class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
        t.string :origin, :destination
        t.references :car, foreign_key: :car
        t.datetime :start_time, :end_time
        t.decimal :distance, :new_passenger_cost, :total_trip_cost
        t.boolean :completed
      t.timestamps
    end
  end
end
