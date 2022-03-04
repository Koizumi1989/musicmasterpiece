class MasterPiece < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true
  validates :introduction, presence: true
  validates :jenre, presence: true
  validates :artist, presence: true
  # validates :rate, presence: true
end
