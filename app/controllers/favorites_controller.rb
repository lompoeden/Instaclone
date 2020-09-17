class FavoritesController < ApplicationController
  def create
      favorite = current_user.favorites.create(post_id: params[:post_id])
      redirect_to posts_url, notice: "#you have favourited{favorite.post.user.name}'s post"
    end

    def destroy
      favorite = current_user.favorites.find_by(id: params[:id]).destroy
      redirect_to posts_url, notice: "#you have deleted{favorite.post.user.name}'s post"
    end
end
