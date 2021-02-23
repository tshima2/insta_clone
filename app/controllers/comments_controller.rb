class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ edit update destroy ]  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if(@comment.content.empty?)
      notice=t('comments.msg_content_empty')
    elsif(@comment.save)
      notice=t('comments.msg_create_success')
    else
      notice=t('comments.msg_create_fail')
    end
    redirect_to feed_path(@comment.feed.id), notice: notice
  end

  def edit
  end

  def update
    byebug

    if(@comment.update(comment_params))
      notice=t('comments.msg_update_success')
    else
      notice=t('comments.msg_update_fail')
    end
    redirect_to feed_path(@comment.feed.id), notice: notice
  end

  def destroy
    if(@comment.destroy)
      notice=t('comments.msg_destroy_success')
    else
      notice=t('comments.msg_destroy_fail')
    end
    redirect_to feed_path(@comment.feed_id), notice: notice
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])    
  end
  
  def comment_params
    params.require(:comment).permit(:user_id, :feed_id, :content)
  end
end
