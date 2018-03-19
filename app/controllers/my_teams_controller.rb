class MyTeamsController < ApplicationController
  before_action :set_my_team, only: [:show, :edit, :update, :destroy]

  require 'rest-client'
  # GET /my_teams
  # GET /my_teams.json
  def index
    @my_teams = MyTeam.all
  end

  def getAllTeams
    response = RestClient.get('https://statsapi.web.nhl.com/api/v1/teams/')
    all_teams = JSON.parse(response)["teams"]
    @all_teams = []
    all_teams.map do |t|
      @all_teams.push(["#{t["name"]}", "#{t["name"]}-#{t["id"]}"])
    end
    @all_teams
  end

  # GET /my_teams/1
  # GET /my_teams/1.json
  def show
    id = @my_team.team_id.split("-")[1]
    roster = RestClient.get("https://statsapi.web.nhl.com/api/v1/teams/#{id}/roster")
    @roster = JSON.parse(roster)["roster"]
  end

  # GET /my_teams/new
  def new
    @my_team = MyTeam.new
    @all_teams = getAllTeams
  end

  # GET /my_teams/1/edit
  def edit
    @all_teams = getAllTeams
  end

  # POST /my_teams
  # POST /my_teams.json
  def create
    @my_team = MyTeam.new(my_team_params)

    respond_to do |format|
      if @my_team.save
        format.html { redirect_to @my_team, notice: 'My team was successfully created.' }
        format.json { render :show, status: :created, location: @my_team }
      else
        format.html { render :new }
        format.json { render json: @my_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /my_teams/1
  # PATCH/PUT /my_teams/1.json
  def update
    respond_to do |format|
      if @my_team.update(my_team_params)
        format.html { redirect_to @my_team, notice: 'My team was successfully updated.' }
        format.json { render :show, status: :ok, location: @my_team }
      else
        format.html { render :edit }
        format.json { render json: @my_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_teams/1
  # DELETE /my_teams/1.json
  def destroy
    @my_team.destroy
    respond_to do |format|
      format.html { redirect_to my_teams_url, notice: 'My team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_team
      @my_team = MyTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def my_team_params
      params.permit(:team_id, :league)
    end
end
