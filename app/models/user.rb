class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :master_pieces, dependent: :destroy
  has_many :master_piece_comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :like_master_pieces, through: :likes, source: :master_piece

  # 退会していないuserのみを取得する。userに関わるもの全てのcontrollerに適応される。
  # is_deleted：falseは退会していないuserのこと
  default_scope { where(is_deleted: false) }

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  has_one_attached :image

  # guest
  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # 検索
  def self.search(search, word) #User.@@（ここではsearch)でも良い。（selfはUserクラスを指す）
    # 完全一致→perfect_match
    if search == "perfect_match"
      @user = self.where("name LIKE?", "#{word}")
      # 前方一致→forward_match
    elsif search == "forward_match"
      @user = self.where("name LIKE?", "#{word}%")
      # 後方一致→backword_match
    elsif search == "backward_match"
      @user = self.where("name LIKE?", "%#{word}")
      # 部分一致→partial_match
    elsif search == "partial_match"
      @user = self.where("name LIKE?", "%#{word}%")
    else
      @user = self.all
    end
  end

  # 退会ユーザーかまだ生きてるユーザーかを聞いて、falseなら入れなくする。
  def active_for_authentication?
    self.is_deleted == false
  end

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
