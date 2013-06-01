class HomeController < ApplicationController
  def index

    @user = User.find_by_id(session[:user_id])
    @team = @user.team

    @sorted_teams = Team.sort

    @sorted_teams.each_with_index do |team , x|
      if team.name == @team.name
        @num = x
      end
    end


    @perc = ((@user.activities.total_distance/@user.goal) * 100).round(2)

    @perc_t = ((@team.total_distance/@team.goal) * 100).round(2)


    @memb_comp = []
    User.all.each do |x|
      if x.activities.total_distance == x.goal
        @memb_comp << x
      end
    end
  end


  def goal_page
    @sports = ["Cycling" , "Running"]
    @user = User.find_by_id(session[:user_id])

  end

end
