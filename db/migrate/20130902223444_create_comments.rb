class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id
      t.integer :answer_id

      t.timestamps
    end
    
    add_index :comments, :user_id
    add_index :comments, :question_id
    add_index :comments, :answer_id
  end
end
