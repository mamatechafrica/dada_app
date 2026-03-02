class AddFieldsToShares < ActiveRecord::Migration[8.0]
  def change
    add_column :shares, :anonymous, :boolean
    add_column :shares, :status, :integer
    add_column :shares, :published_at, :datetime
  end
end
