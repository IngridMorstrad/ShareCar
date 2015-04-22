class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
        t.references :borrower
        t.references :lender
        t.decimal :amount
      t.timestamps
    end
  end
end
