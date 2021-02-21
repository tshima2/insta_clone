class FavoritesController < ApplicationController
  def new
    @favorite=Favorite.new
  end

  def create
    @favorite = Favorite.new(favorite_params)
    if(@favorite.save)
      notice="favorite successfully created."
    else
      notice=t('something ERROR has occured in create favorite. ')
    end
    redirect_to feed_path(@favorite.feed.id), notice: notice
  end

  def destroy
    if @favorite=Favorite.find_by(user_id: params[:favorite][:user_id], feed_id: params[:favorite][:feed_id])
      if @favorite.present?
        @favorite.destroy
        notice='your favorite successfully destroyed.'
      else notice='your favorite to this feed is NOT FOUND.'
      end
    else
      notice='your favorite to this feed is NOT FOUND.'
    end
    redirect_to feed_path(@favorite.feed_id), notice: notice
  end

  private
  def favorite_params
    params.require(:favorite).permit(:user_id, :feed_id)
  end
end
