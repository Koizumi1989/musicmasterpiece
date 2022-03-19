class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visited_id
      t.integer :visiter_id
      t.integer :master_piece_id
      t.integer :master_piece_comment_id
      t.string :action
      t.boolean :checked, default: false
      t.timestamps
    end
  end
end
