class FeedsController < ApplicationController
  before_action :set_feed, only: %i[ show edit update destroy ]

  # GET /feeds or /feeds.json
  def index
    if(current_user)
      if(params[:id].present? && params[:id].to_i == current_user.id)
        @feeds = User.find(current_user.id).favorite_feeds
      else
        @feeds = Feed.all.order(updated_at: 'DESC')
      end
    else
      authenticate_user
    end
  end

  # GET /feeds/1 or /feeds/1.json
  def show
    if(current_user)
      @comments = @feed.comments.order(updated_at: 'DESC')
      @comment = Comment.new if (!@comment = Comment.find_by(user_id: current_user.id, feed_id: @feed.id))
      @favorites = @feed.favorites.order(updated_at: 'DESC')
      @favorite = Favorite.new if (!@favorite = Favorite.find_by(user_id: current_user.id, feed_id: @feed.id))
    else
      authenticate_user
    end
  end

  # GET /feeds/new
  def new
    if(current_user)
      if params[:back]
        @feed = Feed.new(feed_params)
      else
        @feed = Feed.new
      end
    else
      authenticate_user
    end
  end

  # GET /feeds/1/edit
  def edit
  end

  def confirm
    @feed = Feed.new(feed_params)    
  end

  # POST /feeds or /feeds.json
  def create
    @feed = Feed.new(feed_params)
    respond_to do |format|
      if @feed.save
        FeedsMailer.feeds_mail(@feed).deliver
        format.html { redirect_to @feed, notice: t('feeds.msg_create_feed_success') }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1 or /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params) && (@feed.user_id == current_user.id)
        format.html { redirect_to @feed, notice: t('feeds.msg_update_feed_success') }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1 or /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: t('feeds.msg_destroy_feed_success') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_feed
    @feed = Feed.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def feed_params
    params.require(:feed).permit(:user_id, :image, :image_cache, :content)
  end
end
