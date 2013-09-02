class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :pic_url
      t.string :website
      t.string :location
      t.integer :age
      t.datetime :last_on
      t.integer :profile_views

      t.timestamps
    end
  end
end
