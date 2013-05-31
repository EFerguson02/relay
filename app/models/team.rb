class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users

  def total_distance

  end

  def goal

  end

end
