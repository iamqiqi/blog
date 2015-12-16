class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followee_id

      t.timestamps null: false
    end
    add_index :relationships, :followee_id
    add_index :relationships, :follower_id
    add_index :relationships, [:follower_id, :followee_id], unique: true
  end
end
