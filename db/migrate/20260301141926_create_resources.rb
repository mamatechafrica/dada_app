class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.text :content
      t.string :content_type

      t.timestamps
    end
  end
end
