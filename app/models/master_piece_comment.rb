class MasterPieceComment < ApplicationRecord
  belongs_to :user
  belongs_to :master_piece

end
