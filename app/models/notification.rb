class Notification < ApplicationRecord
  
    belongs_to :master_piece, optional: true
    belongs_to :master_piece_comment, optional: true
    belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
    belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
