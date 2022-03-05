class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :master_pieces, dependent: :destroy
  has_many :master_piece_comments, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  has_one_attached :image

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
