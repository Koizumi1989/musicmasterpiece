class CreateMasterPieces < ActiveRecord::Migration[6.1]
  def change
    create_table :master_pieces do |t|
      t.string :title
      t.string :artist
      t.string :jenre
      t.text :introduction
      t.integer :user_id
      t.float :rate
      t.timestamps
    end
  end
end
