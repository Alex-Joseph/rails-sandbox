class PlayersController < ApplicationController
    require 'uri'
    require 'net/http'
    require 'openssl'

    def index
        @players = Player.all
    end

    def date(d)
      date = Date.parse d
      date.strftime("%b %e")
    end
    helper_method :date

    def show
      @current_year = Time.new.year
      p = params[:id].split("/")
      @name = p[0]
      @position = p[1]
      @id = p[2]
      stats = RestClient.get("https://statsapi.web.nhl.com/api/v1/people/#{@id}/stats?stats=gameLog&season=#{@current_year-1}#{@current_year}")
      @stats = JSON.parse(stats)["stats"][0]["splits"]
      if @position === "Goalie"
        render :show_goalie_stats
      end
    end

    def new
        @player = Player.new
    end

    def edit
        @player = Player.find(params[:id])
    end

    def create
        @player = Player.new(player_params)

        if @player.save
            redirect_to @player
        else
            render "new"
        end
    end

    def update
        @player = Player.find(params[:id])

        if @player.update(player_params)
            redirect_to @player
        else
            render 'edit'
        end
    end

    def destroy
        @player = Player.find(params[:id]).destroy
        redirect_to players_path
    end

    private

        def player_params
            params.require(:player).permit(:first_name, :last_name, :born_on)
        end
end
