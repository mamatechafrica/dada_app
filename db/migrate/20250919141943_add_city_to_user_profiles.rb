class AddCityToUserProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :user_profiles, :city, :string
  end
end
