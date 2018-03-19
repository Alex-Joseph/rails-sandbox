class AddTeamNameToMyTeams < ActiveRecord::Migration
  def change
    add_column :my_teams, :team_name, :string
    add_column :my_teams, :team_id, :int
    remove_column :my_teams, :teamName, :string
  end
end
