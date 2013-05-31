class ChangeColumnGoalInUsers < ActiveRecord::Migration
  def change
    change_column :users, :goal, :decimal
  end
end
