require 'nokogiri'
require 'open-uri'

module YongBot
  module Commands
    module Dispatch
      extend Discordrb::Commands::CommandContainer

      command(:dispatch,
              description: 'returns most recent dispatch.co.kr post',
              usage: '.dispatch'
              ) do |event|
        page = Nokogiri::HTML(open('http://www.dispatch.co.kr/today'))
        title = page.css('div.col h6').first.text
        url = "http://www.dispatch.co.kr" + page.css('div.container-fluid a').first.first[1]
        event.respond "#{title}: #{url}"
      end

    end
  end
end
