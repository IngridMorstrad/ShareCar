class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.references :car
      t.references :user

      t.timestamps
    end
  end
end
