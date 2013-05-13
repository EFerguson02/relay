class AccessController < ApplicationController

  def log_in
  end

  def remote_login
    code = params[:code]
    response = HTTParty.post("https://runkeeper.com/apps/token?grant_type=authorization_code&code=#{code}&client_id=2352dbda60b94f7fa07649bded3aa8c2&client_secret=b2fae9603ac741dd9c3429f55af8568a&redirect_uri=http://localhost:3000/access/remote_login")
    token = response["access_token"]
    rkUser  = JSON.parse(HTTParty.get("https://api.runkeeper.com/user?access_token=#{token}"))
    rkProfile = JSON.parse(HTTParty.get("https://api.runkeeper.com/profile?access_token=#{token}"))
    user = User.find_by_rk_id(rkUser["userID"]) || User.create_from_rk(token, rkUser["userID"], rkProfile['name'])
    if user
      session[:user_id] = user.id
      session[:user_name] = user.name
      session[:access_token] = user.access_token
      redirect_to user_url(user.id)
    else
      redirect_to root_url, notice: "Log in error"
    end
  end

  def log_out
    session.delete(:user_id)
    session.delete(:user_name)
    session.delete(:access_token)
  end
end
