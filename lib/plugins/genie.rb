require 'nokogiri'
require 'open-uri'

module YongBot
  module Commands
    module Genie
      extend Discordrb::Commands::CommandContainer

      command(:genie,
              description: 'returns current song at specified genie rank',
              min_args: 1,
              max_args: 1,
              usage: '.genie [num]'
              ) do |event, *num|
        return event.respond 'invalid num bru' if num.join.to_i < 1
        return event.respond 'less than 21 bru' if num.join.to_i > 50
        page = Nokogiri::HTML(open("http://www.genie.co.kr/chart/f_top_100.asp"))
        title  = page.css('span.music_area a.title')[num.join.to_i].text
        artist = page.css('span.music_area a.artist')[num.join.to_i].text
        date   = page.css('div.chart-date input#curDateComma').first.values.last
        hour   = page.css('div.chart-date input#strHH').first.values.last
        event.respond "Genie Rank #{num.join}: #{artist} - #{title} | #{date} #{hour}:00KST"
      end

    end
  end
end
