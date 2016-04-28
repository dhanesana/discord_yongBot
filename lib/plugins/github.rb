require 'unirest'
require 'open-uri'

module YongBot
  module Commands
    module Github
      extend Discordrb::Commands::CommandContainer

      command(:github,
              description: 'returns most recently pushed commit message from specified github user',
              min_args: 1,
              max_args: 1,
              usage: '.github [user]'
              ) do |event, *user|
        response = Unirest.get("https://api.github.com/users/#{URI.encode(user.join)}/repos?&sort=pushed&client_id=#{ENV['GITHUB_ID']}&client_secret=#{ENV['GITHUB_SECRET']}").body
        return event.respond "user not found bru" if response.first[1] == 'Not Found'
        i = 0
        while i < 100
          repo = response[i]['name']
          response_2 = Unirest.get("https://api.github.com/repos/#{user.join}/#{repo}/commits?&client_id=#{ENV['GITHUB_ID']}&client_secret=#{ENV['GITHUB_SECRET']}").body
          if response_2.first[1].nil?
            message = response_2.first['commit']['message']
            message = message.slice(0..(message.index("\n") - 1)) if message.include? "\n"
            commit_url = response_2.first['html_url']
            break
          else
            i += 1
          end
        end
        event.respond "Last Commit: '#{message}' #{commit_url}"
      end

    end
  end
end
