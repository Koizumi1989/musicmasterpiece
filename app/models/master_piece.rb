class MasterPiece < ApplicationRecord
  belongs_to :user
  has_many :master_piece_comments, dependent: :destroy


  has_one_attached :image
  validates :title, presence: true
  validates :introduction, presence: true
  validates :jenre, presence: true
  validates :artist, presence: true
  # validates :rate, presence: true

  def get_image
    if image.attached?
      image
    else
      'record.jpg'
    end
  end
end
