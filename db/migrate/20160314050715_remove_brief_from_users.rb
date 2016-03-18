class RemoveBriefFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :brief
  end
end
