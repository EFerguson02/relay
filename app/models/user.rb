class User < ActiveRecord::Base

  attr_accessible :name, :access_token, :user_Id

  validates_uniqueness_of :rk_id, :access_token

  def self.create_from_rk(token, user_Id, name)
    user = User.new
    user.name = name
    user.access_token = token
    user.rk_id = user_Id
    user.save
    return user
  end

  def activities
    activities = JSON.parse(HTTParty.get("https://api.runkeeper.com/fitnessActivities?access_token=#{self.access_token}"))
    return activities["items"]
  end

end
