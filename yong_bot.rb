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
  bot.include! Commands::Kst
  bot.include! Commands::Agb
  bot.include! Commands::Asc
  bot.include! Commands::Buzz
  bot.include! Commands::Choice
  bot.include! Commands::Cpme
  bot.include! Commands::Csgo
  bot.include! Commands::Daum
  bot.include! Commands::Dispatch
  bot.include! Commands::Eat
  bot.include! Commands::Flickr
  bot.include! Commands::Fresh
  bot.include! Commands::Gaon
  bot.include! Commands::Genie
  bot.include! Commands::Github
  bot.include! Commands::Nba
  bot.include! Commands::Horo

  bot.run

end
