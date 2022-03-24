class Like < ApplicationRecord
  belongs_to :user
  belongs_to :master_piece
  validates :user_id, uniqueness: { scope: :master_piece_id }
end
