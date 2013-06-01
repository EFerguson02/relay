class User < ActiveRecord::Base

  attr_accessible :name, :access_token, :rk_id, :goal, :team_id

  belongs_to :team

  validates_presence_of :name, :access_token, :rk_id
  #validates_uniqueness_of :rk_id, :access_token

  def self.create_from_rk(token, user_Id, name)
    user = User.new
    user.name = name
    user.access_token = token
    user.rk_id = user_Id
    user.save
    return user
  end

  def activities
    #return all actiities by this user

    activities = []
    api_activities = JSON.parse(HTTParty.get("https://api.runkeeper.com/fitnessActivities?access_token=#{self.access_token}"))
    api_activities["items"].each do |item|
      activity = Activity.new(item)
      activities.push(activity)
    end
    return activities
  end

  def this_week_activities
    #should fetch all activities from api.
    activities = []
    api_activities = JSON.parse(HTTParty.get("https://api.runkeeper.com/fitnessActivities?access_token=#{self.access_token}"))
    api_activities["items"].each do |item|
    #pass them to Activity.new
      activity = Activity.new(item)
      activities.push(activity)
    #pick ones that are from the current week
    end
  end

end

class Activity

  def initialize( stats )
    @type = stats["type"]
    @start_time = stats["start_time"]
    if stats["duration"]
      @duration = to_min_sec(stats["duration"])
    else
      @duration = "0:00"
    end
    stats["total_distance"] ? @distance = meters_to_miles(stats["total_distance"]) : @distance = 0.00
  end

private

  def to_time(start_time)
    #takes a string eg. "Mon, 13 May 2013 02:13:57"
    #returns a Time object of the same date
  end

  def to_min_sec(num)
    minutes = (num/60).floor.to_s
    seconds = (num%60).floor.to_s
    seconds = '0' + seconds if seconds.to_i < 10
    return "#{minutes}:#{seconds}"
  end

  def meters_to_km(meters)
    kilometers = meters/1000
    return kilometers
  end

  def meters_to_miles(meters)
    miles = meters * 0.000621371192
    return miles
  end

public

  def type
    @type
  end

  def start_time
    @start_time
  end

  def duration
    @duration
  end

  def distance
    @distance
  end

end

class Array

  def total_distance
    sum = 0.00
    self.each do |activity|
      if activity.class == Activity
        sum += activity.distance
      end
    end
    return sum
  end

end
