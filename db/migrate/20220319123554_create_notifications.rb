class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visited_id, null: false
      t.integer :visitor_id, null: false
      t.integer :master_piece_id
      t.integer :master_piece_comment_id
      t.string :action, default: false, null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :master_piece_id
    add_index :notifications, :master_piece_comment_id
  end
end
