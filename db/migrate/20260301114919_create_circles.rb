class CreateCircles < ActiveRecord::Migration[8.0]
  def change
    create_table :circles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
