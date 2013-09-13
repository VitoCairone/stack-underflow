class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.integer :best_answer_id
      t.integer :view_count

      t.timestamps
    end
    
    add_index :questions, :user_id
  end
end
