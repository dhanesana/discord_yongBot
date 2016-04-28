require 'httparty'
require 'open-uri'

module YongBot
  module Commands
    module Fresh
      extend Discordrb::Commands::CommandContainer

      command(:fresh,
              description: 'returns random new [FRESH] post from r/hiphopheads',
              usage: '.fresh'
              ) do |event|
        response = HTTParty.get("http://www.reddit.com/r/hiphopheads/.json")
        fresh = {}
        response['data']['children'].each do |post|
          fresh[post['data']['title']] = post['data']['url'] if post['data']['title'].include? '[FRESH'
        end
        fresh_array = fresh.to_a
        num = rand(0..fresh_array.size - 1)
        event.respond "#{fresh_array[num][0]}: #{fresh_array[num][1]}"
      end

    end
  end
end
