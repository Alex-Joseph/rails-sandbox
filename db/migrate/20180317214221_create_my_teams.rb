class CreateMyTeams < ActiveRecord::Migration
  def change
    create_table :my_teams do |t|
      t.string :teamName
      t.string :league

      t.timestamps null: false
    end
  end
end
