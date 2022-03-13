class LikesController < ApplicationController
  def index
    # TODO: work on it later
    # Likeモデルのuser_idカラムがcurrent_user.idのmaster_piece_idカラムを取得する
    master_piece_ids = Like.where(user_id: current_user.id).pluck(:master_piece_id)
    if params[:sort] == "desc"
      @master_pieces = MasterPiece.where(id: master_piece_ids).page(params[:page]).order(created_at: :desc)
    elsif params[:sort] == "asc"
      @master_pieces = MasterPiece.where(id: master_piece_ids).page(params[:page]).order(created_at: :asc)
    else
      @master_pieces = MasterPiece.where(id: master_piece_ids).page(params[:page]).order(created_at: :desc)
    end
  end

  def create
    @master_piece = MasterPiece.find(params[:master_piece_id])
    like = Like.new(master_piece_id: @master_piece.id, user_id: current_user.id)
    like.save
    # redirect_to request.referer
  end

  def destroy
    @master_piece = MasterPiece.find(params[:master_piece_id])
    like = current_user.likes.find_by(master_piece_id: @master_piece.id)
    like.destroy
    # redirect_to request.referer
  end
end
