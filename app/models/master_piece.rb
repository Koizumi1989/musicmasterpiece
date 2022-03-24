class MasterPiece < ApplicationRecord
  belongs_to :user
  has_many :master_piece_comments, dependent: :destroy
  has_many :likes
  has_many :notifications, dependent: :destroy
  has_one_attached :image

  validates :title, :introduction, :jenre, :artist, :rate, presence: true

  # このモデルでimpressionableを使用可能に
  is_impressionable

  # ソート機能 try the scope
  scope :recent, -> { order(created_at: :desc) }

  # お気に入り
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  # 検索機能
  def self.search(search, word)
    # 完全一致→perfect_match
    if search == "perfect_match"
      @master_piece = where(['artist LIKE(?) OR title LIKE(?) OR jenre LIKE(?)', "#{word}", "#{word}", "#{word}"])
      # 前方一致→forward_match
    elsif search == "forward_match"
      @master_piece = where(['artist LIKE(?) OR title LIKE(?) OR jenre LIKE(?)', "#{word}%", "#{word}%", "#{word}%"])
      # 後方一致→backword_match
    elsif search == "backward_match"
      @master_piece = where(['artist LIKE(?) OR title LIKE(?) OR jenre LIKE(?)', "%#{word}", "%#{word}", "%#{word}"])
      # 部分一致→partial_match
    elsif search == "partial_match"
      @master_piece = where(['artist LIKE(?) OR title LIKE(?) OR jenre LIKE(?)', "%#{word}%", "%#{word}%", "%#{word}%"])
    else
      @master_piece = all
    end
  end

  def get_image
    if image.attached?
      image
    else
      'record.jpg'
    end
  end

  # お気に入り通知
  def create_notification_like!(current_user, user_id, id)
    # すでに「いいね」されているか検索
    # visitor_id = current_user.idでもいいが、インジェクション攻撃対策で？にしている。
    temp = Notification.where(["visitor_id = ? and visited_id = ? and master_piece_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      # active_notificationsはアソシエーション
      notification = current_user.active_notifications.new(
        master_piece_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # validationに引っ掛からなければセーブする。
      notification.save if notification.valid?
    end
  end

  # コメント通知
  def create_notification_comment!(current_user, master_piece_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = MasterPieceComment.select(:user_id).where(master_piece_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, master_piece_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, master_piece_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, master_piece_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      master_piece_id: id,
      master_piece_comment_id: master_piece_comment_id,
      visited_id: visited_id,
      action: 'master_piece_comment'
    )
    notification.save if notification.valid?
  end
end
