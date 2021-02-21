class CommentsController < ApplicationController
  def new
    byebug

    @comment = Comment.new
  end

  def create
    byebug

    @comment = Comment.new(comment_params)
    if(@comment.save)
      notice='comment has successfully created.'
    else
      notice='somthing ERROR has occured in create comment.'
    end
    redirect_to feed_path(@comment.feed.id), notice: notice
  end

  def destroy
    byebug

    if @comment=Comment.find_by(user_id: params[:comment][:user_id], feed_id: params[:comment][:feed_id])
      if @comment.present?
        @comment.destroy
        notice='your comment successfully destroyed.'
      else
        notice='your comment to this feed is NOT FOUND.'
      end
    else
      notice='your comment to this feed is NOT FOUND.'
    end
    redirect_to feed_path(@comment.feed_id), notice: notice
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :feed_id, :content)
  end
end
