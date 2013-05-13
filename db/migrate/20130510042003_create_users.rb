class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :rk_id
      t.string :access_token
      t.string :name
      t.timestamps
    end
  end
end
