# !/bin/env ruby
#
# Wordpress to Disqus Comment Converter
# =====================================
# Mark Reid <mark@reid.name>
#
# Set your Disqus user API key using
#
#     $ export DISQUS_KEY=[Key]
#
# Some inspiration drawn from the following post:
#
#     http://gweezlebur.com/2009/01/05/mephisto-to-disqus.html
#
require 'rubygems'
require 'rest_client'
require 'sequel'
require 'json'

USER_KEY = ENV['DISQUS_KEY']

DISQUS_BASE = 'http://disqus.com/api/'
DISQUS = RestClient::Resource.new DISQUS_BASE

def get(command, args)
  path = command + '?' + args.map {|k,v| "#{k}=#{v}"}.join('&')
  response = JSON.parse( DISQUS[path].get )
  raise "Bad response to #{path}" unless response['succeeded']
  response['message']
end

forum_list = get('get_forum_list', :user_api_key => USER_KEY)
forum_id = forum_list[0]['id']
forum_key = get('get_forum_api_key', :user_api_key => USER_KEY, :forum_id => forum_id)

puts forum_key
# DB = Sequel.mysql('inductio', :user=>'root', :password=>'', :host=>'localhost')
# DB["select * from wp_comments"].each do |row|
#   puts "#{row[:comment_ID]}"
# end
