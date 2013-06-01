class UsersController < ApplicationController

before_filter :confirm_logged_in

def show
  @user = User.find_by_id(params[:id])
end

def index
  @users = User.all
end

def update
  @user = User.find_by_name(session[:user_name])
  @user.goal = params['user']['goal']
  @user.save
  redirect_to homepage_url

end

end
