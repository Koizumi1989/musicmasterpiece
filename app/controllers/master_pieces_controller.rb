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
    @master_pieces = MasterPiece.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
  end


  private

  def master_piece_params
    params.require(:master_piece).permit(:image, :title, :artist, :jenre, :introduction)
  end
end
