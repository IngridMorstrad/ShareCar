class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.integer :trip_id
      t.integer :user_id

      t.timestamps
    end
  end
end
