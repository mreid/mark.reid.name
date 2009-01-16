require 'rubygems'
#require 'rest-client'
require 'sequel'

USER_KEY = ENV['DISQUS_KEY']

DB = Sequel.mysql('inductio', :user=>'root', :password=>'', :host=>'localhost')
DB["select * from wp_comments"].each |row| do
  
end
