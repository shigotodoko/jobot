require "twitter"

module Jobot
  class Tweet
    class << self
      def all
        client.user_timeline
      end

      def update(post)
        client.update(build_message(post))
      end

      def build_message(post)
        "#{post.title} - #{post.url} #japao #empregosnojapao #shigotodoko"
      end

      def client
        @client ||= Twitter::REST::Client.new do |config|
          config.consumer_key         = ENV['TWITTER_CONSUMER_KEY']
          config.consumer_secret      = ENV['TWITTER_CONSUMER_SECRET']
          config.access_token         = ENV['TWITTER_OAUTH_TOKEN']
          config.access_token_secret  = ENV['TWITTER_OAUTH_TOKEN_SECRET']
        end
      end
    end

    def initialize(tweet)
      @tweet = tweet
    end

    def id
      url.to_s[/\d+/]
    end

    def url
      @tweet.urls.first.expanded_url
    end
  end
end
