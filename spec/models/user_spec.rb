require 'spec_helper'


describe User do

  user = User.new(   :rk_id => "19274013",
                              :access_token => "563cb05a18024f63b63c81d608158cb3",
                              :name => "Lauri Kinnunen",
                              :goal => 32.23637893)

  it "is valid with a name, rk_id and access_token" do
    expect(user).to be_valid
  end

  it "is automatically assigned to a team" do
    user.save
    expect(user.team).to be_present
  end

  it "is invalid without a name" do
    expect(User.new(name: nil)).to have(1).errors_on(:name)
  end

  it "is invalid without an access_token" do
    expect(User.new(access_token: nil)).to have(1).errors_on(:access_token)
  end

  it "is invalid without a rk_id" do
    expect(User.new(rk_id: nil)).to have(1).errors_on(:rk_id)
  end

  it "is invalid with a duplicate rk_id" do
    user1 = User.create(
      name: "Lauri",
      rk_id: 2,
      access_token: 3741839471344)
    user2 = User.create(
      name: "Lauri",
      rk_id: 2,
      access_token: 3741839471345)
    expect(user2).to have(1).errors_on(:rk_id)
  end

  it "is invalid with a duplicate access_token" do
    user1 = User.create(
      name: "Lauri",
      rk_id: 1,
      access_token: 3741839471344)
    user2 = User.create(
      name: "Lauri",
      rk_id: 2,
      access_token: 3741839471344)
    expect(user2).to have(1).errors_on(:access_token)
  end

  its "access_token can be used to fetch data from API" do
    api_activities = JSON.parse(HTTParty.get("https://api.runkeeper.com/fitnessActivities?access_token=#{user.access_token}"))
    puts api_activities["items"].first
    expect(api_activities["items"].first.class).to eq Hash
  end

  its "activities returns all activities by the user" do
      expect(user.activities.first.class).to eq Activity
  end

  its "this_week_activity returns activities for the current week" do
    #result should be an array only containing activities from current week
  end

  its "goal has presicion of two decimals" do
    user.save
    expect(user.goal).to eq 32.24
  end

end

describe Activity do

  activity = Activity.new(  {"type" => "Running",
                                    "start_time" => "Mon, 13 May 2013 02:13:57",
                                    "duration" => 680.841,
                                    "total_distance" => 4000.47598128055325 })

  it "should convert Health Graph date strings to Time objects" do
    puts activity.start_time
    expect(activity.start_time.class).to eq Time
  end

  its "distance is in miles with presicion of two decimals" do
    expect(activity.distance).to eq  2.49
  end

  its "duration is minutes:seconds (eg. '12:30')" do
    expect(activity.duration).to eq '11:20'
  end

end

describe Array do

  activity = Activity.new(  {"type" => "Running",
                                    "start_time" => "Mon, 13 May 2013 02:13:57",
                                    "duration" => 680.841,
                                    "total_distance" => 4000.47598128055325 })

  its "total_distance is the sum of activities.distance" do
    activities = [activity, activity, activity]
    expect(activities.total_distance).to eq 2.49*3
  end

end

