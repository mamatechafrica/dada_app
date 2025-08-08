class CreateUserProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stage
      t.text :symptoms
      t.text :preferences
      t.string :region
      t.string :language
      t.boolean :completed_onboarding

      t.timestamps
    end
  end
end
