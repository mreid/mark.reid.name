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
      :created_at   => row[:comment_date].strftime("%Y-%m-%dT%H:%M"),
      :message      => clean(row[:comment_content])
    }
end

def clean(comment)
  comment.gsub!(/<\/?p>/,'')
  comment
end

def url(row)
  date_path = row[:comment_date_gmt].strftime("%Y/%m/%d")
  "http://mark.reid.dev/iem/#{row[:post_name]}.html"
end

def thread(row) 
  ident_str = "test-#{row[:post_name]}"
  data = { 
    :forum_api_key => FORUM_KEY,
    :title => row[:post_title], 
    :identifier => ident_str
  }

  puts "Getting thread #{ident_str}..."
  response = JSON.parse( DISQUS['thread_by_identifier'].post(data) )

  # puts response.to_yaml
  # puts "--- (end thread response)"
  
  raise "Bad response to get thread ID for #{ident_str}" unless response['succeeded']

  puts "Thread [#{ident_str}] has title '#{response['message']['thread']['title']}'"

  response['message']['thread']['id']
end

def update(thread_id, url)
  data = {
    :forum_api_key => FORUM_KEY,
    :thread_id => thread_id,
    :url => url
  }

  puts "Updating thread #{thread_id} with URL = #{url}"
  response = JSON.parse( DISQUS['update_thread'].post(data) )
end

# Converts and sends a comment from the DB to Disqus with the given thread ID
@unconverted = []
@threads = {}
def post(row, thread_id)
  data = convert(row)
  data[:forum_api_key] = FORUM_KEY
  data[:thread_id] = thread_id
  
  puts("Sending comment to thread #{thread_id}")
  
  response = JSON.parse( DISQUS['create_post'].post(data) )
  
  if response['succeeded']
    @threads[thread_id] = url(row)
  else
    puts "\tWARNING: Could not post comment by #{data[:author_name]} on #{data[:created_at]}"
    @unconverted << data
  end
end

# Processing begins here...
DB_PASS = ENV['DB_PASS']
DB = Sequel.mysql(DB_NAME, :user=>DB_USER, :password=>DB_PASS, :host=>'localhost')

USER_KEY = ENV['DISQUS_KEY']
FORUM_KEY = forum_key

LIMIT = "limit 10"
QUERY = "select * from wp_comments, wp_posts where wp_comments.comment_post_ID = wp_posts.ID and comment_type != 'pingback' #{LIMIT}"
DB[QUERY].each do |row|
  puts "Processing #{row[:comment_type]} comment #{row[:comment_ID]}..."
  thread_id = thread(row)
  post(row, thread_id)
end

puts "Number of failures: #{@unconverted.length}"

@threads.each do |tid,url| 
  update(tid,url)
end

