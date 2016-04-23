
module YongBot
  module Commands
    module Kst
      extend Discordrb::Commands::CommandContainer

      command(:kst, description: 'returns date and time(KST)') do |event|
        utc = Time.now.utc
        kst = utc + (9 * 3600)
        time = kst.strftime("%F %H:%M KST")
        event.respond time
      end

    end
  end
end
