class AddStatusToTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :topics, :status, :integer
    add_column :topics, :views_count, :integer
  end
end
