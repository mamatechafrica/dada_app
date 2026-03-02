class CreateShares < ActiveRecord::Migration[6.1]
  def change
    create_table :shares do |t|
      t.references :user, null: false, foreign_key: true
      t.string :share_type, null: false
      t.string :title
      t.text :content
      t.text :image_urls
      t.string :video_url
      t.string :visibility, null: false, default: "private"
      t.integer :likes_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0

      t.timestamps
    end
    add_index :shares, :share_type
    add_index :shares, :visibility
  end
end
