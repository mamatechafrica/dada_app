class CreateStories < ActiveRecord::Migration[8.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :content
      t.string :author_name
      t.string :author_location
      t.integer :author_age
      t.string :stage
      t.text :tags
      t.boolean :verified
      t.string :region

      t.timestamps
    end
  end
end
