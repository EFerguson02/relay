require 'spec_helper'

describe Team do

team = Team.create({ :name => "Tigers"})

users = User.create([
  { :goal => 314.12, :rk_id => "19274013", :access_token => "563cb05a18024f63b63c81d608158cb3", :name => "Lauri Kinnunen", :team_id => team.id},
  { :goal => 424.42, :rk_id => "19325936", :access_token => "bd24dc1c9e4640d597f68fb8efed166e", :name => "George Pittas",  :team_id => team.id },
  { :goal => 225.43, :rk_id => "19504366", :access_token => "bf4440aad7b74597978834ca24ea5d98", :name => "Jacob", :team_id => team.id }])

  its "total distance is the sum of its members' total_distances" do
    total_distance = users[0].activities.total_distance + users[1].activities.total_distance + users[2].activities.total_distance
    expect(team.total_distance).to eq total_distance
  end

  its "goal is the sum of its members' goals" do
    goal = users[0].goal + users[1].goal + users[2].goal
    expect(team.goal).to eq goal
  end

end
