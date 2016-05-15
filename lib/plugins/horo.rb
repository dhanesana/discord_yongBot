require 'nokogiri'
require 'open-uri'

module YongBot
  module Commands
    module Horo
      extend Discordrb::Commands::CommandContainer

      command(:horo,
              description: 'returns ur daily horoscope for those that are into that kinda thing',
              min_args: 1,
              max_args: 1,
              usage: '.horo [sign]'
              ) do |event, *sign|
        page = Nokogiri::HTML(open("http://new.theastrologer.com/#{sign.join}/"))
        text = page.css('div#today p').first.text
        date = page.css('div#today div.daily-horoscope-date').first.text
        event.respond "[#{date}] #{text}"
      end

    end
  end
end
