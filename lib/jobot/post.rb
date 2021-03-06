require "httpi"
require "json"
require "./lib/jobot/log"

module Jobot
  class Post
    class << self
      include Jobot::Log

      def all
        response = fetch

        parse(response.body).map { |attributes| new(attributes) }
      end

      def find(id)
        all.find { |post| post.id == id }
      end

      def fetch
       HTTPI.get(request)
      end

      def request
        Jobot::Log.log("debug", "Requesting the published posts")
        HTTPI::Request.new.tap do |req|
          req.url = "https://www.shigotodoko.com/api/posts/published"
          req.headers = { "Content-Type" => "application/json" }
          req.auth.ssl.verify_mode = :none
        end
       end

      def parse(collection)
        JSON.parse(collection)
      end
    end

    attr_reader :id, :title, :url

    def initialize(attrs = {})
      @id = attrs["id"]
      @title = attrs["title"]
    end

    def url
      "https://www.shigotodoko.com/posts/#{id}"
    end
  end
end
