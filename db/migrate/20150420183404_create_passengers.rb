class CreatePassengers < ActiveRecord::Migration
  def change
    create_table :passengers do |t|
      t.references :trip
      t.references :user

      t.timestamps
    end
  end
end
