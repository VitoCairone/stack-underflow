class CreateCommentQs < ActiveRecord::Migration
  def change
    create_table :comment_qs do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
