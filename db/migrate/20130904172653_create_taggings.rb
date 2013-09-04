class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :question_id
      t.integer :answer_id
      t.integer :user_id

      t.timestamps
    end
  end
end
