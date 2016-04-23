
module YongBot
  module Commands
    module Ping
      extend Discordrb::Commands::CommandContainer

      command(:ping) do |event|
        event.respond "pooong!"
      end

    end
  end
end
