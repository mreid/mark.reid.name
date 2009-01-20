require 'rubygems'
require 'rest_client'
require 'json'

DISQUS_BASE = 'http://disqus.com/api/'
DISQUS = RestClient::Resource.new DISQUS_BASE

SOURCE_URL = 'http://mark.reid.dev/iem/'
TARGET_URL = 'http://mark.reid.name/iem/'

THREADS = {
10211725 => 'http://mark.reid.name/iem/behold-jensens-inequality.html',
10211748 => 'http://mark.reid.name/iem/feed-bag-a-simple-rss-archiver.html',
10211737 => 'http://mark.reid.name/iem/visualising-reading.html',
10211738 => 'http://mark.reid.name/iem/snuck-flied-and-wedded.html',
10211739 => 'http://mark.reid.name/iem/super-crunchers.html',
10211728 => 'http://mark.reid.name/iem/colt-2008-highlights.html',
10211784 => 'http://mark.reid.name/iem/staying-organised-with-citeulike-and-bibdesk.html',
10211740 => 'http://mark.reid.name/iem/constructive-and-classical-mathematics.html',
10211730 => 'http://mark.reid.name/iem/the-earth-is-round.html',
10211753 => 'http://mark.reid.name/iem/information-divergence-and-risk.html',
10211742 => 'http://mark.reid.name/iem/ml-and-stats-people-on-twitter.html',
10211720 => 'http://mark.reid.name/iem/a-meta-index-of-data-sets.html',
10211710 => 'http://mark.reid.name/iem/introducing-inductio-ex-machina.html',
10211755 => 'http://mark.reid.name/iem/artificial-ai.html',
10211733 => 'http://mark.reid.name/iem/machine-learning-summer-school-2009.html',
10211711 => 'http://mark.reid.name/iem/clarity-and-mathematics.html',
10211713 => 'http://mark.reid.name/iem/a-cute-convexity-result.html',
}

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

def threads
  thread_list = get('get_thread_list', :forum_api_key => FORUM_KEY)
end

# Set the URL of the Disqus thread to the given value
def update(thread_id, url)
  data = {
    :forum_api_key => FORUM_KEY,
    :thread_id => thread_id,
    :url => url
  }

  puts "Updating thread #{thread_id} with URL = #{url}"
  response = JSON.parse( DISQUS['update_thread'].post(data) )
end

USER_KEY = ENV['DISQUS_KEY']
FORUM_KEY = forum_key

# Set the new URLs
# threads.each do |t|
#   url = THREADS[t['id'].to_i]
#   next if url.nil?
#   update(t['id'], url)
#   puts "Set thread #{t['id']} to #{url}"
# end

# Check everything worked
threads.each do |t|
  url = THREADS[t['id'].to_i]
  next if url.nil?
  puts "Thread #{t['id']} has #{url}"
end
