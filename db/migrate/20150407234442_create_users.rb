class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.time :oauth_expires_at
      t.timestamps
    end
  end
end
