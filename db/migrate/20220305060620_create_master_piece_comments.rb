class CreateMasterPieceComments < ActiveRecord::Migration[6.1]
  def change
    create_table :master_piece_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :master_piece_id

      t.timestamps
    end
  end
end
