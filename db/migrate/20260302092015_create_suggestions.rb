class CreateSuggestions < ActiveRecord::Migration[8.0]
  def change
    create_table :suggestions do |t|
      t.string :title
      t.text :description
      t.integer :circle_id
      t.integer :user_id
      t.integer :status
      t.text :reason

      t.timestamps
    end
  end
end
