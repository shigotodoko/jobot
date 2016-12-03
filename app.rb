require "sinatra"
require "./lib/jobot"

get "/" do
  Jobot.talk
end
