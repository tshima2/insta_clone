class SessionsController < ApplicationController
  before_action
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_sessions_path
  end

  def new
    user=User.new
  end

  def create
    user=User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #ログイン成功した場合
      session[:user_id] = user.id

      if(current_user)
        redirect_to feeds_path
      else
        redirect_to user_path(user.id)
      end
    else
      #ログイン失敗した場合
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  
end
