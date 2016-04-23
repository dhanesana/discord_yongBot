require 'nokogiri'
require 'open-uri'

module YongBot
  module Commands
    module Buzz
      extend Discordrb::Commands::CommandContainer

      command(:buzz,
              description: 'returns most recent netizenbuzz post',
              usage: '.buzz'
              ) do |event|
        page = Nokogiri::HTML(open('http://netizenbuzz.blogspot.com/'))
        title = page.css('h3.post-title a').first.text
        url = page.css('h3.post-title a').first.attributes.first[1].value
        event.respond "#{title}: #{url}"
      end

    end
  end
end
