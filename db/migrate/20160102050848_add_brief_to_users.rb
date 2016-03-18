class AddBriefToUsers < ActiveRecord::Migration
  def change
    add_column :users, :brief, :string
  end
end
