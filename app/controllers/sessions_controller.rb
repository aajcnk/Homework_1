class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:current_user_id] = user_id
  		redirect_to root_url, notice: "Добро пожаловать!"
  	else
  		flash.now.alert = "Email или пароль не верный"
  		render "new"
  	end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end
end
