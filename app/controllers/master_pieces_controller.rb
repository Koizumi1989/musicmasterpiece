class MasterPiecesController < ApplicationController

  impressionist
  # pv数を計測したいアクション
  impressionist :actions => [:show]

  # 他人のmaster_piece/edit/updateできないように。
  before_action :correct_user, only: [:edit, :update]

  def new
    @master_piece = MasterPiece.new
  end

  def create
    @master_piece = MasterPiece.new(master_piece_params)
    @master_piece.user_id = current_user.id
    if @master_piece.save
      flash[:notice] = '名盤を投稿しました'
      redirect_to master_piece_path(@master_piece.id)
    else
      render :new
    end
  end

  # ソート機能
  def index
    @page = MasterPiece.page(params[:page])
    if params[:sort] == "new_arrival_order"
      @master_pieces = @page.recent #scope
    elsif params[:sort] == "posting_order"
      @master_pieces = @page.order(created_at: :asc) #カラム名：：並び方
    elsif params[:sort] == "highly_rated"
      @master_pieces = @page.order(rate: :desc)
    elsif params[:sort] == "low_rating"
      @master_pieces = @page.order(rate: :asc)
    else
      @master_pieces = @page.recent
    end
  end

  def show
    @master_piece = MasterPiece.find(params[:id])
    impressionist(@master_piece, nil, unique: [:session_hash])
    @master_piece_comment = MasterPieceComment.new
  end

  def edit
    @master_piece = MasterPiece.find(params[:id])
  end

  def update
    @master_piece = MasterPiece.find(params[:id])
    if @master_piece.update(master_piece_params)
      redirect_to master_piece_path(@master_piece.id), notice: "名盤を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @master_piece = MasterPiece.find(params[:id])
    @master_piece.destroy
    flash[:notice] = '名盤を消去しました'
    redirect_to master_pieces_path
  end

  def post_destroy_all
    @user = current_user
    @user.master_pieces.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private
  
  def master_piece_params
    params.require(:master_piece).permit(:title, :artist, :jenre, :introduction, :rate)
  end

  # 他人の投稿編集画面に遷移できなくする。
  def correct_user
    @master_piece = MasterPiece.find(params[:id])
    @user = @master_piece.user
    redirect_to master_piece_path(@master_piece.id) unless @user == current_user
  end
end
