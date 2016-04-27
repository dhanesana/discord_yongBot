require 'rss'

module YongBot
  module Commands
    module Cpme
      extend Discordrb::Commands::CommandContainer

      command(:cpme,
              description: 'returns most recent crayonpop.me post',
              usage: '.cpme'
              ) do |event|
        url = 'https://crayonpop.me/feed/'
        open(url) do |rss|
          feed = RSS::Parser.parse(rss)
          event.respond "#{feed.items.first.title}: #{feed.items.first.link}"
        end
      end

    end
  end
end
