class User < ActiveRecord::Base

  attr_accessible :name, :access_token, :rk_id

  belongs_to :team

  validates_presence_of :name, :access_token, :rk_id
  validates_uniqueness_of :rk_id, :access_token

  def self.create_from_rk(token, user_Id, name)
    user = User.new
    user.name = name
    user.access_token = token
    user.rk_id = user_Id
    user.save
    return user
  end

  def activities(time_frame = nil)

    #return all actiities by this user
    #return activities for current week if time_frame == :this_week

    activities = JSON.parse(HTTParty.get("https://api.runkeeper.com/fitnessActivities?access_token=#{self.access_token}"))
    return activities["items"]
  end

  def all_activities
    #passes user to Activity.all and returns the callback
  end

  def past_week_activities
    #passes user to Activity.this_week and returns the callback
  end

end

class Activity

  def initialize( stats )
    @type = stats[:type]
    @start_time = to_time(stats[:start_time])
    @duration = to_min_sec(stats[:duration])
    @total_distance = stats[:total_distance]
  end

private

  def to_time(start_time)
    #takes a string eg. "Mon, 13 May 2013 02:13:57"
    #returns a Time object of the same date
  end

  def to_min_sec(float)
    minutes = (float/60).floor.to_s
    seconds = (float%60).floor.to_s
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

  def total_distance
    @total_distance
  end

  def self.this_week(user)
    #returns an array of activities by one user, the start_time of which is on the current week
  end

  def self.all(user)
    #returns all activities by one user
  end

end

class Array

  def distance
    # if all items.class == Activity
    # return the sum of total distances
    # else raise exception: "Not an Activity object"
  end

end
