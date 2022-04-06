class MasterPieceCommentsController < ApplicationController
  # 自分ののコメントしか消せないようにする。
  before_action :correct_user, only: [:destroy]

  def create
    @master_piece_comment = MasterPieceComment.new
    @master_piece = MasterPiece.find(params[:master_piece_id])
    comment = MasterPieceComment.new(master_piece_comments_params)
    comment.user_id = current_user.id
    comment.master_piece_id = @master_piece.id
    comment.save
    @master_piece.create_notification_comment!(current_user, comment.id)
  end

  def destroy
    master_piece_comments = MasterPieceComment.find(params[:id])
    @master_piece = master_piece_comments.master_piece
    master_piece_comments.destroy
  end

  private

  def master_piece_comments_params
    params.require(:master_piece_comment).permit(:comment)
  end

  # 自分のコメントしか消せないようにする。
  def correct_user
    @master_piece_comments = MasterPieceComment.find(params[:id])
    @user = @master_piece_comments.user
    redirect_to request.referer unless @user == current_user
  end

end
