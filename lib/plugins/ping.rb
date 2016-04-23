
module YongBot
  module Commands
    module Ping
      extend Discordrb::Commands::CommandContainer

      command(:ping, description: 'responds if alive') do |event|
        event.respond "pooong!"
      end

    end
  end
end
