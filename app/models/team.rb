class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users

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
    return goal
  end

end
