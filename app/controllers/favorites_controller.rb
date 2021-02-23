class FavoritesController < ApplicationController
  def new
    @favorite=Favorite.new
  end

  def create
    @favorite = Favorite.new(favorite_params)
    if(@favorite.save)
      notice=t('favorites.msg_create_success')
    else
      notice=t('favorites.msg_create_fail')
    end
    redirect_to feed_path(@favorite.feed.id), notice: notice
  end

  def destroy
    if @favorite=Favorite.find_by(user_id: params[:favorite][:user_id], feed_id: params[:favorite][:feed_id])
      if @favorite.present?
        @favorite.destroy
        notice=t('favorites.msg_destroy_success')
      else
        notice=t('favorites.msg_destroy_fail')
      end
    else
      notice=t('favorites.msg_destroy_fail')
    end
    redirect_to feed_path(@favorite.feed_id), notice: notice
  end

  private
  def favorite_params
    params.require(:favorite).permit(:user_id, :feed_id)
  end
end
