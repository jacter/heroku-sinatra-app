# You'll need to require these if you
# want to develop while running with ruby.
# The config/rackup.ru requires these as well
# for it's own reasons.
#
# $ ruby heroku-sinatra-app.rb
#
require 'rubygems'
require 'sinatra'
require 'dm-core'

configure :production do
  # Configure stuff here you'll want to
  # only be run at Heroku at boot

  # TIP:  You can get you database information
  #       from ENV['DATABASE_URL'] (see /env route below)
  DataMapper::setup(:default, ENV['DATABASE_URL'])
end

configure :development do
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/database.sqlite3")
end

class Bacon
  include DataMapper::Resource
  property :id, Serial
end

DataMapper.auto_upgrade!

# Quick test
get '/' do
  "Congratulations!
   You're running a Sinatra application on Heroku!"
end

# Test at <appname>.heroku.com

# You can see all your app specific information this way.
# IMPORTANT! This is a very bad thing to do for a production
# application with sensitive information

# get '/env' do
#   ENV.inspect
# end
