class AddMediaFieldsToResources < ActiveRecord::Migration[8.0]
  def change
    add_column :resources, :image_url, :string
    add_column :resources, :video_url, :string
  end
end
