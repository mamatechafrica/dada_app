class CreateTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :circle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
