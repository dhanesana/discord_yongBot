require 'discordrb'
require_relative 'bin/plugins'

module YongBot

  bot = Discordrb::Commands::CommandBot.new(
    token: "#{ENV['BOT_TOKEN']}",
    application_id: ENV['APP_ID'].to_i,
    prefix: '.'
  )

  # LOAD PLUGINS
  bot.include! Commands::Ping
  bot.include! Commands::Lineup

  bot.run

end
