class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search_result
    @word = params[:word]
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @master_pieces = MasterPiece.looks(params[:search], params[:word])
    end
  end
end
