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
require 'parsedate'

require 'rubygems'
require 'rest_client'
require 'sequel'
require 'json'

DISQUS_BASE = 'http://disqus.com/api/'
DISQUS = RestClient::Resource.new DISQUS_BASE

DB_USER = 'root'
DB_NAME = 'inductio'
DB_PASS = ENV['DB_PASS']

# Gets the first forum key associated with USER_KEY
def forum_key
  forum_list = get('get_forum_list', :user_api_key => USER_KEY)
  forum_id = forum_list[0]['id']
  get('get_forum_api_key', :user_api_key => USER_KEY, :forum_id => forum_id)  
end

# Encapsulates request, JSON parsing and error checking a REST call to Disqus
def get(command, args)
  path = command + '?' + args.map {|k,v| "#{k}=#{v}"}.join('&')
  response = JSON.parse( DISQUS[path].get )
  raise "Bad response to #{path}" unless response['succeeded']
  response['message']
end

# Converts the contents of a comment from the database into hash suitable for 
# posting as a comment to Disqus
def convert(row)
    { 
      :author_name  => row[:comment_author],
      :author_email => row[:comment_author_email],
      :author_url   => row[:comment_author_url],
      :ip_address   => row[:comment_author_IP],
      :created_at   => row[:comment_date_gmt].strftime("%Y-%m-%dT%H:%M"),
      :message      => row[:comment_content]
    }
end

def thread(title, id) 
  data = { :title => title, :identifier => id, :forum_api_key => FORUM_KEY }

  puts "Getting thread #{id}..."
  response = JSON.parse( DISQUS['thread_by_identifier'].post(data) )

  puts response.to_yaml
  puts "--- (end thread response)"
  
  raise "Bad response to #{path}" unless response['succeeded']

  response['message']['thread']['id']
end

# Converts and sends a comment from the DB to Disqus with the given thread ID
@unconverted = []
def send_comment(row, thread_id)
  data = convert(row)
  data[:forum_api_key] = FORUM_KEY
  data[:thread_id] = thread_id
  
  response = JSON.parse( DISQUS['create_post'].post(data) )
  
  puts response.to_yaml
  puts "--- (End send response)"
  
  unless response['succeeded']
    puts "\tWARNING: Could not post comment by #{data[:author_name]} on #{data[:created_at]}"
    @unconverted << data
  end
end


# Processing begins here...
DB = Sequel.mysql(DB_NAME, :user=>DB_USER, :password=>DB_PASS, :host=>'localhost')

USER_KEY = ENV['DISQUS_KEY']
FORUM_KEY = forum_key

DB["select * from wp_comments limit 2"].each do |row|
  puts "Processing #{row[:comment_type]} comment #{row[:comment_ID]}..."
  
  thread_id = thread("Testing import", "import-#{row[:comment_post_ID]}")
  send_comment(row, thread_id)
end

print "Number of failures: #{@unconverted.length}"