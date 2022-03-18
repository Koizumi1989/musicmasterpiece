class HomesController < ApplicationController
  def top
    @master_pieces = MasterPiece.all.order(rate: :desc).limit(3)
  end
end
