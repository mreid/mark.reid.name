--- 
layout: iem-post
title: "Feed Bag: A Simple RSS Archiver"
location: Canberra, Australia

excerpt: A brief overview of an RSS archiving tool I whipped up in ruby.

wordpress_id: 28
wordpress_url: http://conflate.net/inductio/application/feed-bag-a-simple-rss-archiver/

---
One thing my [recent survey of freely available data sets][data] did not uncover was a collection of archived RSS feeds. This surprised me a little since I would imagine aggregators like [Bloglines](http://bloglines.com/), [Google Reader](http://google.com/reader) and [AideRSS](http://aiderss.com/) must have large databases of hundreds of thousands of RSS feeds.

[data]: http://conflate.net/inductio/application/a-meta-index-of-data-sets/

Having seen how easy it is to [create an RSS aggregator in ruby][igvita], I figured it should be just as easy to collect feeds in the same way and write them to a database via one of the many ORM (Object-Relational Mapping) layers available in ruby. The excellent [FeedNormalizer][] library makes the first part trivial and avoids having to worry whether a feed is RSS1, RSS2, Atom, etc. For the second part I thought I'd try something new and give the ORM library [Sequel][] a go and, in the interests of simplicity, have it talk to an [SQLite][] database.

[igvita]: http://www.igvita.com/2007/03/22/agile-rss-aggregator-in-ruby/
[feednormalizer]: http://code.google.com/p/feed-normalizer/
[sequel]: http://code.google.com/p/ruby-sequel/
[sqlite]: http://www.sqlite.org/

The part I liked most was how easy Sequel makes setting up database schema. This is the executable ruby code that defines the two tables I use in Feed Bag:

    class Feed < Sequel::Model(:feeds)
      set_schema do
        primary_key   :id
        text          :name
        text          :url
        time          :last_checked
        time          :created
      end
    end
    
    class Entry < Sequel::Model(:entries)
      set_schema do
        primary_key   :id
        text          :url
        text          :title
        text          :content
        text          :description
        time          :time
    
        foreign_key   :feed_id, :table => :feeds
        index         :url
      end
    end

Using it is just as easy. From the ruby-side, if you have a feed `f` you get its associated entries using `f.entries` and once you have an entry `e` you can get its URL or title using `e.url` or `e.title`. Given how easy that is, there's little reason to resort to flat text file formats such as CSV when dealing with this sort of data.

I've called the resulting ruby script "Feed Bag" and have [made it available][feedbag] on my academic website along with instructions for using it. Without comments, the scripts weighs in at about 130 lines of code and only took a few hours to write and debug, most of which was learning how to use FeedNormalizer and Sequel. 

I've been running Feed Bag on my machine since mid-January, collecting international news feeds from the BBC, New York Times, Washington Post, and 7 others without any trouble. So far it's collected over 25,000 feed items and stashed them in a 38Mb SQLite database. If any one is interested, I've made a bzip2 compressed version of an SQL dump of the database available for [download][] (3.4Mb). 

Please let me know if you use the data for anything, or if you use Feed Bag to collect your own data set.

[feedbag]: http://users.rsise.anu.edu.au/~mreid/code/feed_bag.html 
[download]: http://users.rsise.anu.edu.au/~mreid/files/data/IntlNews.sql.bz2
