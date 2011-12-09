require 'json'
require 'net/http'
require_relative 'db'

def fetch(gamertag)
    url = "http://api.xboxleaders.com/v2/?gamertag=#{gamertag}&format=json"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    result = JSON.parse(data)
    JSONFriend.new(result)
end

def update_status(friend)
    json_friend = fetch(friend.gamertag)
    friend.online = json_friend.online
    friend.save     
end

def get_status(json)

end

def update_db
    Friend.all.each do |friend|
        update_status(friend)
    end
end

class JSONFriend
    def initialize(json)
        @json = json
    end

    def gamertag
        @json['user']['gamertag']   
    end

    def online
        @json['user']['online']
    end
end