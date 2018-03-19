json.extract! my_team, :id, :teamName, :league, :created_at, :updated_at
json.url my_team_url(my_team, format: :json)
