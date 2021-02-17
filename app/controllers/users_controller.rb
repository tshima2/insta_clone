class UsersController < ApplicationController

  before_action :set_user_with_id, only: [:edit, :update, :destroy, :show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user=User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path, notice: "投稿を編集しました!"
    else
      notice='保存に失敗しました'
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end

  def set_user_with_id
    @user=User.find(params[:id])
  end
end
