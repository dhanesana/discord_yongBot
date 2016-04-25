
module YongBot
  module Commands
    module Choice
      extend Discordrb::Commands::CommandContainer

      command(:choice,
              description: 'helps you make an otherwise difficult decision',
              min_args: 3,
              usage: '.choice [this] or [that]...'
              ) do |event, *text|
        return event.respond "#{text.join(' ')} or what?" if (text.join(' ').include? 'or') == false
        decision = text.join(' ').split(' or ').sample
        event.respond rand(0..1) < 1 ? "hm.. #{decision}" : "#{decision}!"
      end

    end
  end
end
