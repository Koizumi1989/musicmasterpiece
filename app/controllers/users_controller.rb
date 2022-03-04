class UsersController < ApplicationController
  def index
    @user = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @master_piece = @user.master_pieces
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def search
  end

  def user_params
    params.require(:user).permit(:image, :name, :introduction)
  end
end
