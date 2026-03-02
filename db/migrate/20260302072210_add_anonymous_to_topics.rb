class AddAnonymousToTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :topics, :anonymous, :boolean
  end
end
