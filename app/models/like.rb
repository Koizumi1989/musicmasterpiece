class Like < ApplicationRecord
  belongs_to :user
  belongs_to :master_piece
  validates :user_id, uniqueness: { scope: :master_piece_id }
  
  scope :desc, -> { order(created_at: :desc) } # カラム名：：並び方
  scope :asc, -> { order(created_at: :asc) }
  scope :ratedesc, -> { order(rate: :desc) }
  scope :rateasc, -> { order(rate: :asc) }
end
