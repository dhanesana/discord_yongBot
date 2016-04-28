require 'httparty'
require 'open-uri'
require 'json'

module YongBot
  module Commands
    module Flickr
      extend Discordrb::Commands::CommandContainer

      command(:flickr,
              description: 'returns most recent flickr pic of specified user',
              min_args: 1,
              usage: '.flickr [user]'
              ) do |event, *user|
        username = URI.encode(user.join.split(/[[:space:]]/).join(' ').downcase)
        nsid_request = open("https://api.flickr.com/services/rest/?method=flickr.people.findByUsername&api_key=#{ENV['FLICKR_KEY']}&username=#{username}&format=json&nojsoncallback=1").read
        result = JSON.parse(nsid_request)
        nsid = result['user']['nsid']
        photos_req = open("https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=#{ENV['FLICKR_KEY']}&user_id=#{nsid}&format=json&nojsoncallback=1").read
        response = JSON.parse(photos_req)

        # if no photos are found
        return event.respond 'nada' if response['photos']['photo'].size == 0

        photo_title = response['photos']['photo'].first['title']
        photo_id = response['photos']['photo'].first['id']
        event.respond "https://www.flickr.com/photos/#{nsid}/#{photo_id}/"
      end

    end
  end
end
