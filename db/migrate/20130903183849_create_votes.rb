class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :is_up
      t.integer :user_id
      t.integer :question_id
      t.integer :answer_id

      t.timestamps
    end
    
    add_index :votes, :user_id
    add_index :votes, :question_id
    add_index :votes, :answer_id
  end
end
