require 'nokogiri'
require 'open-uri'

module YongBot
  module Commands
    module Agb
      extend Discordrb::Commands::CommandContainer

      command(:agb,
              description: 'returns tv show at specified daily agb nielson rank',
              min_args: 1,
              max_args: 1,
              usage: '.agb [num]'
              ) do |event, *num|
        return event.respond 'invalid num bru' if num.join == '0'
        return event.respond 'less than 21 bru' if num.join.to_i > 20
        page = Nokogiri::HTML(open('http://www.agbnielsen.co.kr/_hannet/agb/f_rating/rating_01a.asp'))
        date = page.css('span.t_year').text
        return event.respond "#{date}: No Data Available" if page.css('div#boardlist td').size < 4
        station = page.css('div#boardlist td')[3].text if num.join.to_i == 1
        title = page.css('div#boardlist td')[5].text if num.join.to_i == 1
        title.slice! '<td>' if num.join.to_i == 1
        title.slice! '</td>' if num.join.to_i == 1
        return event.respond "#{date}AGB Nielson Rank #{num.join}: #{station} - #{title}" if num.join.to_i == 1
        x = (num.join.to_i - 1) * 12
        station = page.css('div#boardlist td')[3 + x].text
        title = page.css('div#boardlist td')[5 + x].text
        title.slice! '<td>'
        title.slice! '</td>'
        event.respond "#{date}AGB Nielson Rank #{num.join}: #{station} - #{title}"
      end

    end
  end
end
