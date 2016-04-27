require 'nokogiri'
require 'open-uri'

module YongBot
  module Commands
    module Daum
      extend Discordrb::Commands::CommandContainer

      command(:daum,
              description: 'returns trending daum search result at specified rank',
              min_args: 1,
              max_args: 1,
              usage: '.daum [num]'
              ) do |event, *num|
        return event.respond 'invalid num bru' if num.join.to_i < 1
        page = Nokogiri::HTML(open('http://www.daum.net/'))
        text = page.css('ol#realTimeSearchWord div div a')[num.to_i].text.delete!("\n") # NAME
        url = page.css('ol#realTimeSearchWord a')[num.to_i].first[1] # URL
        event.respond "Daum Trending [#{num.join}]: #{text} #{url}"
      end

    end
  end
end
