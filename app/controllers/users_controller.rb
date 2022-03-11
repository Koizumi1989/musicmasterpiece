class UsersController < ApplicationController
  # 他人のuser/edit/updateできないように。
  before_action :ensure_correct_user, only: [:edit, :update]
  # guestが編集画面にurl入力でも遷移不可にする
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.page(params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @master_piece = @user.master_pieces.page(params[:page]).order(created_at: :desc)
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
