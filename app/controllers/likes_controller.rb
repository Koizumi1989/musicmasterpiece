class LikesController < ApplicationController

  def index
    # Likeモデルのuser_idカラムが@userのidの人のmaster_piece_idカラムを取得する
    @user = User.find(params[:user_id])
    master_piece_ids = Like.where(user_id: @user.id).pluck(:master_piece_id)
    @page = MasterPiece.where(id: master_piece_ids).page(params[:page])
    if params[:sort] == "new_arrival_order"
      @master_pieces = @page.desc
    elsif params[:sort] == "posting_order"
      @master_pieces = @page.asc
    elsif params[:sort] == "highly_rated"
      @master_pieces = @page.ratedesc
    elsif params[:sort] == "low_rating"
      @master_pieces = @page.rateasc
    else
      @master_pieces = @page.desc
    end
  end

  def create
    @master_piece = MasterPiece.find(params[:master_piece_id])
    like = Like.new(master_piece_id: @master_piece.id, user_id: current_user.id)
    like.save
    user_id = @master_piece.user.id
    @master_piece.create_notification_like!(current_user, user_id, @master_piece.id)
  end

  def destroy
    @master_piece = MasterPiece.find(params[:master_piece_id])
    like = current_user.likes.find_by(master_piece_id: @master_piece.id)
    like.destroy
  end
end
