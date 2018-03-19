class AddTeamIdToMyTeams < ActiveRecord::Migration
  def change
    remove_column :my_teams, :team_name, :string
    remove_column :my_teams, :team_id, :int
    add_column :my_teams, :team_id, :string
  end
end
