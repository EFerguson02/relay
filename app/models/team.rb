class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users

  def self.sort
  @teams = Team.all
    @distances = {}
    @teams.each do |x|
      @distances["#{x.total_distance}"] = x.name
    end

    @sorted = @distances.keys.sort
    @team_list = []

    @sorted.each do |x|
     @team_list << @distances[x]
    end

    @sorted_teams = []

    @team_list.length.times do |x|
      @sorted_teams << Team.find_by_name(@team_list[x])
      @sorted_teams = @sorted_teams.reverse!

    end
    return @sorted_teams
  end

  def total_distance
    dist = 0
    self.users.each do |user|
      dist += user.activities.total_distance
    end
    return dist
  end

  def goal
    goal = 0
    self.users.each do |user|
      goal += user.goal
    end
    return goal.round(2)
  end

  def acheived_perc
   num = (self.total_distance/self.goal) * 100
   num.round(2)

  end
@teams = Team.all
    @distances = {}
    @teams.each do |x|
      @distances["#{x.total_distance}"] = x.name
    end

    @sorted = @distances.keys.sort
    @team_list = []

    @sorted.each do |x|
     @team_list << @distances[x]
    end

    @sorted_teams = []

    @team_list.length.times do |x|
      @sorted_teams << Team.find_by_name(@team_list[x])
      @sorted_teams = @sorted_teams.reverse!
    end


end
