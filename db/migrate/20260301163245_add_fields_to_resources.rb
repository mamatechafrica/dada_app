class AddFieldsToResources < ActiveRecord::Migration[8.0]
  def change
    add_column :resources, :resource_type, :integer
    add_column :resources, :access_level, :integer
    add_column :resources, :published_at, :datetime
    add_column :resources, :featured, :boolean
  end
end
