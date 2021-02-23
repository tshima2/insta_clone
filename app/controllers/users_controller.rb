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
    if @user.update(user_params) && (@user.id == current_user.id)
      redirect_to edit_user_path, notice: t('users.msg_update_success')
    else
      notice=t('users.msg_update_success')
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
