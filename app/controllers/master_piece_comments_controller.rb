class MasterPieceCommentsController < ApplicationController
  def create
    master_piece = MasterPiece.find(params[:master_piece_id])

    comment = MasterPieceComment.new(master_piece_comments_params)
    comment.user_id = current_user.id
    comment.master_piece_id = master_piece.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    MasterPieceComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def master_piece_comments_params
    params.require(:master_piece_comment).permit(:comment)
  end
end