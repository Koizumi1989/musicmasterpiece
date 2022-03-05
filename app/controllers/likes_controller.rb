class LikesController < ApplicationController

  def create
    @master_piece = MasterPiece.find(params[:master_piece_id])
    like = Like.new(master_piece_id: @master_piece.id, user_id: current_user.id)
    like.save
    redirect_to request.referer
  end
  # paramsはurlから取ってくる。rails routesのurlを確認しておなじにする。
  # rails routesみれば[:book_id]がurl部分にでてくる。またこのbook_idはカラムではなくurl
  # favorite = current_user.favorites.new(book_id: book.id)
  # ここでひつようなのbook_idとuser_idが必要。favoriteテーブルの中のカラム。
  # favorite = current_user.favorites.new(book_id: book.id)と下記記述は同じ内容
  # (左側はカラムの名前：右が代入する値（book=Book.find(params[:book_id])のこと)
  # (左側はカラムの名前：右が代入する値（current_user.id)のこと)

  def destroy
    @master_piece = MasterPiece.find(params[:master_piece_id])
    like = current_user.likes.find_by(master_piece_id: @master_piece.id)
    like.destroy
    redirect_to request.referer
  end
end
