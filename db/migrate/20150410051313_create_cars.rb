class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
        t.string :make, :model
        t.integer :year
        t.decimal :cost_per_mile
      t.timestamps
    end
  end
end
