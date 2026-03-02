class AddSlugAndColorToCircles < ActiveRecord::Migration[8.0]
  def change
    add_column :circles, :slug, :string
    add_column :circles, :color, :string
  end
end
