class UsersController < ApplicationController
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
end
