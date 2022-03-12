class MasterPiece < ApplicationRecord
  belongs_to :user
  has_many :master_piece_comments, dependent: :destroy
  has_many :likes

  has_one_attached :image
  validates :title, presence: true
  validates :introduction, presence: true
  validates :jenre, presence: true
  validates :artist, presence: true
  validates :rate, presence: true


  # お気に入り
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  # 検索機能
  def self.looks(search, word)
    # 完全一致→perfect_match
    if search == "perfect_match"
      @master_piece = MasterPiece.where(['artist LIKE(?) OR title LIKE(?) OR jenre LIKE(?)', "#{word}", "#{word}", "#{word}"])
      # 前方一致→forward_match
    elsif search == "forward_match"
      @master_piece = MasterPiece.where(['artist LIKE(?) OR title LIKE(?) OR jenre LIKE(?)', "#{word}%", "#{word}%", "#{word}%"])
      # 後方一致→backword_match
    elsif search == "backward_match"
      @master_piece = MasterPiece.where(['artist LIKE(?) OR title LIKE(?) OR jenre LIKE(?)', "%#{word}", "%#{word}", "%#{word}"])
      # 部分一致→partial_match
    elsif search == "partial_match"
      @master_piece = MasterPiece.where(['artist LIKE(?) OR title LIKE(?) OR jenre LIKE(?)', "%#{word}%", "%#{word}%", "%#{word}%"])
    else
      @master_piece = MasterPiece.all
    end
  end

  def get_image
    if image.attached?
      image
    else
      'record.jpg'
    end
  end
end
