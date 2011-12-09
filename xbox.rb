require 'sinatra'
require "sinatra/json"
require_relative 'db'

set :port, 4567

get '/' do
    stream do |out|
    out << "It's gonna be legen -\n"
    sleep 0.5
    out << " (wait for it) \n"
    sleep 1
    out << "- dary!\n"
  end
end

get '/xbox' do
  redirect "/xbox/list" 
end

get '/xbox/add' do
  erb :add
end

post '/xbox/add' do
  friend = Friend.new
  friend.gamertag = gamertag = params[:gamertag]
  if friend.save
    "Added #{gamertag}"
  else
    friend.errors.each do |error|
      puts error
    end
  end
end

get '/xbox/list??:format?' do  
  case params[:format]
    when /json/  
    Friend.all.to_json
    when /xml/
        Friend.all.to_xml
    else
        stream do |out|
          out << "<ul>"
          Friend.all.each do |friend|
            out << "<li>#{friend.gamertag} - #{friend.online}</li>"
          end
          out << "</ul>"
        end
  end
end