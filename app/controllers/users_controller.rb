class UsersController < ApplicationController
  # 他人のuser/edit/updateできないように。
  before_action :ensure_correct_user, only: [:edit, :update]
  # guestが編集画面にurl入力でも遷移不可にする
  before_action :ensure_guest_user, only: [:edit]

  # 退会
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  # 投稿日を指定して、投稿件数を検索
  def search
    @user = User.find(params[:user_id])
    @master_pieces = @user.master_pieces
    @master_piece = MasterPiece.new
    if params[:created_at] == ""
      @search_master_piece = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_master_piece = @master_pieces.where("created_at LIKE?", "#{create_at}%").count
    end
  end

  def index
    if params[:sort] == "ascending_order"
      @users = User.page(params[:page]).order(created_at: :desc) # カラム名：：並び方
    elsif params[:sort] == "descending_order"
      @users = User.page(params[:page]).order(created_at: :asc)
    else
      @users = User.page(params[:page]).order(created_at: :desc)
    end
  end

  def show
    @user = User.find(params[:id])
    if params[:sort] == "new_arrival_order"
      @master_piece = @user.master_pieces.page(params[:page]).order(created_at: :desc)
    elsif params[:sort] == "posting_order"
      @master_piece = @user.master_pieces.page(params[:page]).order(created_at: :asc)
    elsif params[:sort] == "highly_rated"
      @master_piece = @user.master_pieces.page(params[:page]).order(rate: :desc)
    elsif params[:sort] == "low_rating"
      @master_piece = @user.master_pieces.page(params[:page]).order(rate: :asc)
    else
      @master_piece = @user.master_pieces.page(params[:page]).order(created_at: :desc)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "会員情報を更新しました"
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:image, :name, :introduction)
  end

  # 他人のユーザー編集画面に遷移できなくする。
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  # guestユーザーが編集画面に遷移できなくする。
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
