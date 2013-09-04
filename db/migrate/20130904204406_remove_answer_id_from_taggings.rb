class RemoveAnswerIdFromTaggings < ActiveRecord::Migration
  def up
    remove_column :taggings, :answer_id
  end

  def down
    add_column :taggings, :answer_id, :integer
  end
end
