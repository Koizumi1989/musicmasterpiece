class MasterPieceComment < ApplicationRecord
  belongs_to :user
  belongs_to :master_piece
  
  has_many :notifications, dependent: :destroy
  validates :comment, presence: true
end
