require 'spec_helper'


describe User do

  user = User.new(   :rk_id => "19274013",
                              :access_token => "563cb05a18024f63b63c81d608158cb3",
                              :name => "Lauri Kinnunen",
                              :goal => 32.23637893)

  it "is valid with a name, rk_id and access_token" do
    expect(user).to be_valid
  end

  it "should be automatically assigned to a team" do
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

  its "this_week_activity returns activities for the current week" do
    #should fetch all activities from api.
    #pick ones that are from the current week
    #pass them to Activity.new.
    #result should be an array only containing activities from current week
  end

  its "goal has presicion of two decimals" do
    user.save
    expect(user.goal).to eq 32.24
  end

end

describe Activity do

  activity = Activity.new(  type: "Running",
                                    start_time: "Mon, 13 May 2013 02:13:57",
                                    duration: 680.841,
                                    total_distance: 4.47598128055325)

  it "should convert Health Graph date strings to Time objects" do
    expect(activity.start_time.class).to eq Time
  end

  it "should return total_distance as miles with the presicion of two decimals" do
    expect(activity.total_distance).to eq 4.48
  end

  it "should return duration as minutes:seconds (eg. '12:30')" do
    expect(activity.duration).to eq '11:20'
  end


end
