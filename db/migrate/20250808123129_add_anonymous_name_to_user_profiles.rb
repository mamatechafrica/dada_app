class AddAnonymousNameToUserProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :user_profiles, :anonymous_name, :string
  end
end
