require 'date'
require 'time'
require 'json'

module YongBot
  module Commands
    module Nba
      extend Discordrb::Commands::CommandContainer

      command(:nba,
              description: 'daily nba feed. 🏀 is life',
              usage: '.nba'
              ) do |event|
        utc = Time.now.utc
        today_pdt = utc + Time.zone_offset('PDT')
        today = today_pdt.strftime("%Y%m%d")
        feed = open("http://data.nba.com/5s/json/cms/noseason/scoreboard/#{today}/games.json").read
        result = JSON.parse(feed)
        return event.respond "no games today bru" if result['sports_content']['games'] == ""
        num_of_games = result['sports_content']['games']['game'].size
        games = "|"
        games_2 = "|"
        i = 0
        while i < num_of_games
          home = result['sports_content']['games']['game'][i]['home']['nickname']
          home_score = result['sports_content']['games']['game'][i]['home']['score']
          visitor = result['sports_content']['games']['game'][i]['visitor']['nickname']
          visitor_score = result['sports_content']['games']['game'][i]['visitor']['score']
          period = result['sports_content']['games']['game'][i]['period_time']['period_status']
          clock = result['sports_content']['games']['game'][i]['period_time']['game_clock']
          period += " #{clock}" unless clock == ""
          if i < 5
            games += " #{home}: #{home_score}, #{visitor}: #{visitor_score} [#{period}] |"
          else
            games_2 += " #{home}: #{home_score}, #{visitor}: #{visitor_score} [#{period}] |"
          end
          i += 1
        end
        event.respond games
        event.respond games_2 unless games_2 == "|"
      end

    end
  end
end
