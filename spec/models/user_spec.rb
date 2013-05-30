require 'spec_helper'

describe User do
  it "is valid with a name, rk_id and access_token" do
    user = User.new(
      name: "Lauri",
      rk_id: "234",
      access_token: "4289288392849238")
    expect(user).to be_valid
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
    user = User.create(
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
    user = User.create(
      name: "Lauri",
      rk_id: 1,
      access_token: 3741839471344)
    user2 = User.create(
      name: "Lauri",
      rk_id: 2,
      access_token: 3741839471344)
    expect(user2).to have(1).errors_on(:access_token)
  end

end

describe Activity do

  it "should convert Health Graph date strings to Time objects"
  it "should convert seconds to minutes and seconds"
  it "should convert meters to miles"
  it "should return an array of all fitness activities by one user"
  it "should return an array of all fitness activities by one user for the on-going week"
  it ""

end
