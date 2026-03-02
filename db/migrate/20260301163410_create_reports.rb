class CreateReports < ActiveRecord::Migration[8.0]
  def change
    create_table :reports do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :share, null: false, foreign_key: true
      t.string :reason
      t.integer :status

      t.timestamps
    end
  end
end
