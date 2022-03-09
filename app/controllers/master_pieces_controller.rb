class MasterPiecesController < ApplicationController

  def new
    @master_piece = MasterPiece.new
  end

  def create
    @master_piece = MasterPiece.new(master_piece_params)
    @master_piece.user_id = current_user.id
    if @master_piece.save
      flash[:notice] = 'You have created item successfully'
      redirect_to master_piece_path(@master_piece.id)
    else
      render :new
    end
  end

  def index
    @master_pieces = MasterPiece.page(params[:page]).order(created_at: :desc)
  end

  def show
    @master_piece = MasterPiece.find(params[:id])
    @master_piece_comment = MasterPieceComment.new
  end

  def edit
    @master_piece = MasterPiece.find(params[:id])
  end

  def update
    @master_piece = MasterPiece.find(params[:id])
    if @master_piece.update(master_piece_params)
      redirect_to master_piece_path(@master_piece.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @master_piece = MasterPiece.find(params[:id])
    @master_piece.destroy
    redirect_to master_pieces_path
  end

  private

  def master_piece_params
    params.require(:master_piece).permit(:title, :artist, :jenre, :introduction, :rate)
  end
end
