class UsersController < ApplicationController

before_filter :confirm_logged_in

def show
  @user = User.find_by_id(params[:id])
end

end
