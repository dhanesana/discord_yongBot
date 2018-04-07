require 'nokogiri'
require 'open-uri'

module YongBot
  module Commands
    module Asc
      extend Discordrb::Commands::CommandContainer

      command(:asc,
              description: 'returns summary for upcoming arirang after school club episode',
              usage: '.asc'
              ) do |event|
        begin
          page = Nokogiri::HTML(open('http://www.arirang.co.kr/Tv2/Tv_PlusHomepage_Full.asp?PROG_CODE=TVCR0688&MENU_CODE=101717&sys_lang=Eng'))
          date = page.css('div.ahtml_h2').text
          guest = page.css('div.ahtml_h1').text
          event.respond "After School Club - #{guest} | #{date}"
        rescue Exception => e
          return event.respond "Error: #{e}"
        end
      end

    end
  end
end
