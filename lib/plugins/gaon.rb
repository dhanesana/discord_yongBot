require 'nokogiri'
require 'open-uri'

module YongBot
  module Commands
    module Gaon
      extend Discordrb::Commands::CommandContainer

      command(:gaon,
              description: 'returns trending daum search result at specified rank',
              min_args: 1,
              max_args: 1,
              usage: '.gaon [num]'
              ) do |event, *num|
        return event.respond 'invalid num bru' if num.join.to_i < 1
        page = Nokogiri::HTML(open('http://gaonchart.co.kr/main/section/chart/online.gaon?nationGbn=T&serviceGbn=ALL'))
        rank = num.join.to_i - 1
        title = page.css('td.subject')[rank].css('p').first.text
        artist = page.css('td.subject')[rank].css('p')[1].text
        artist = artist.slice(0..(artist.index('|') - 1))
        event.respond "Gaon Rank #{num.join}: #{title} by #{artist}"
      end

    end
  end
end
