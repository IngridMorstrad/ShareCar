class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
        t.integer :loanee
        t.integer :loaner
        t.float :amount
      t.timestamps
    end
  end
end
