class HomesController < ApplicationController
  def top
    @master_pieces = MasterPiece.all.order(rate: :desc).limit(4)
  end
end
