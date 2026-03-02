class AddParentToTags < ActiveRecord::Migration[8.0]
  def change
    add_column :tags, :parent_id, :integer
  end
end
