require 'eventmachine'
require 'em-websocket'
require 'em-redis'

INCOMING_KEY = 'readit'

EventMachine::run {
  REDIS = EventMachine::Protocols::Redis.connect
  EventMachine::WebSocket.start(:host => "localhost", :port => 7654) do |ws|
    recv = lambda do
      REDIS.brpop ::INCOMING_KEY, 0, do |key, message|      
        ws.send  message
        recv.call      
      end
    end

    ws.onopen do
      puts "WebSocket connection open"
      recv.call
    end

    ws.onclose do
      puts "Connection closed" 
    end

    ws.onmessage do |data|
      puts "Recieved message: #{data}"
    end
  end
}

