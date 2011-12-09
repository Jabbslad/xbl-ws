require "rubygems"
require "data_mapper"

DataMapper.setup(:default, "sqlite3:xbox.db")

class Friend
  include DataMapper::Resource

  property :id,     Serial 
  property :gamertag,   String, :unique => true
  property :online,     Boolean
end

def create
  DataMapper.auto_migrate!
end