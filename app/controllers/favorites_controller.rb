class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(post_id: params[:post_id])
    redirect_to posts_url, notice: "#you have liked {favorite.post.user.name}'s post"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to posts_url, notice: "#you have deleted like for {favorite.post.user.name}'s post"
  end

  def show
    @favorites = current_user.favorites.order(created_at: "DESC")
  end
end
