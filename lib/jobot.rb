app_env = Sinatra::Base.environment

if app_env == :development
  require "dotenv"
  Dotenv.load(File.expand_path("./lib/.env.#{app_env}"))
end

require "./lib/jobot/post"
require "./lib/jobot/tweet"

module Jobot
  def self.talk
    # get all posts
    posts = Jobot::Post.all

    # get the first tweet from the user_timeline
    tweets = Jobot::Tweet.all
    tweet  = Jobot::Tweet.new(tweets.first)

    # remove the first tweet from the posts list
    valid_ids = posts.map(&:id) - [tweet.id]

    # get a post sample
    picked_id = valid_ids.sample

    # find the post
    post = Jobot::Post.find(picked_id)

    # prepare the message and tweet
    Jobot::Tweet.update(post)

  end
end
