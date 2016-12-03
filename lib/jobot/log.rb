module Jobot
  module Log
    def self.log(level, message)
      @log ||= Logger.new(STDOUT)
      @log.level = Logger::DEBUG
      @log.send(level, "[Jobot] - #{message}")
    end
  end
end
