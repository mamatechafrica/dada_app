class AddOnboardingFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :stage, :string
    add_column :users, :symptoms, :text
    add_column :users, :country, :string
  end
end
