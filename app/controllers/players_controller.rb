class PlayersController < ApplicationController
    require 'uri'
    require 'net/http'
    require 'openssl'

    def index
        @players = Player.all
    end

    def leafs
        url = URI("https://api.sportradar.us/nhl/trial/v5/en/teams/441730a9-0f24-11e2-8525-18a905767e44/profile.json?api_key=qs5r85k6mjz8g9gxjjvjgksg")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)

        response = http.request(request)
        @tml = response.read_body
        @p_tml = JSON.parse(@tml)
        @players = @p_tml['players']
    end

    def age(dob)
        now = Time.now.utc.to_date
        date = dob.to_date
        now.year - date.year - ((now.month > date.month || (now.month == date.month && now.day >= date.day)) ? 0 : 1)
    end
    helper_method :age

    def height(ins)
        ins.to_i
        "#{ins/12}'#{ins%12}''"
    end
    helper_method :height

    def status(stat)
        if stat['injuries']
            return stat['injuries'][0][status]
        elsif stat == 'ACT'
            return 'Active'
        else
            return stat
        end
    end
    helper_method :status

    def draft(d)
        @pick = d['pick']
        @round = d['round']
        @year = d['year']
        "Pick Number: #{@pick} Round: #{@round} Year: #{@year}"
    end
    helper_method :draft

    def date(d)
      date = Date.parse d
      date.strftime("%b %e")
    end
    helper_method :date

    def show
      @current_year = Time.new.year
      id = params[:id].split("-")[1]
      stats = RestClient.get("https://statsapi.web.nhl.com/api/v1/people/#{id}/stats?stats=gameLog&season=#{@current_year-1}#{@current_year}")
      @stats = JSON.parse(stats)["stats"][0]["splits"]
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
