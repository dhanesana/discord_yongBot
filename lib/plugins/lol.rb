require 'open-uri'
require 'json'

module YongBot
  module Commands
    module Lol
      extend Discordrb::Commands::CommandContainer

      command(:lol,
              description: 'returns stats of most recent game from specified league of legends player',
              min_args: 1,
              max_args: 1,
              usage: '.lol [username]'
              ) do |event, *user|
        link = open("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{user.join}?api_key=#{ENV['LOL_KEY']}").read
        result = JSON.parse(link)
        id = result.first[1]['id']
        link_2 = open("https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{id}/recent?api_key=#{ENV['LOL_KEY']}").read
        result_2 = JSON.parse(link_2)
        type = result_2['games'].first['subType']
        champ_id = result_2['games'].first['championId']
        level = result_2['games'].first['stats']['level']
        kills = result_2['games'].first['stats']['championsKilled']
        deaths = result_2['games'].first['stats']['numDeaths']
        cs = result_2['games'].first['stats']['minionsKilled'].to_i + result_2['games'].first['stats']['neutralMinionsKilled'].to_i
        assists = result_2['games'].first['stats']['assists']
        time = (result_2['games'].first['stats']['timePlayed']/60.00).round(2)
        link_3 = open("https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/#{champ_id}?api_key=#{ENV['LOL_KEY']}").read
        result_3 = JSON.parse(link_3)
        champ_name = result_3['name']
        game_result = result_2['games'].first['stats']['win'] ? "Win" : "Loss"
        event.respond "#{type}(#{game_result}): Level #{level} #{champ_name} => #{kills} Kills, #{deaths} Deaths, #{assists} Assists, #{cs} Creep Kills, #{time} Minutes Played"
      end

    end
  end
end
