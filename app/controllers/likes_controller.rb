class LikesController < ApplicationController

  def index
    # Likeモデルのuser_idカラムがcurrent_user.idのmaster_piece_idカラムを取得する
    master_piece = Like.where(user_id: current_user.id).pluck(:master_piece_id)
    @master_pieces = MasterPiece.find(master_piece)#.page(params[:page])
  end

  def create
    @master_piece = MasterPiece.find(params[:master_piece_id])
    like = Like.new(master_piece_id: @master_piece.id, user_id: current_user.id)
    like.save
    redirect_to request.referer
  end

  def destroy
    @master_piece = MasterPiece.find(params[:master_piece_id])
    like = current_user.likes.find_by(master_piece_id: @master_piece.id)
    like.destroy
    redirect_to request.referer
  end
end
