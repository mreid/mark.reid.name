---
layout: name
section: Code
title: Feed Bag - A Simple RSS Archiver
---

Feed Bag - A Simple RSS Archiver {: .emphnext :}
================================
RSS is a great format for communicating the _most recent_ stories, comments or
changes on a site but does not usually go back further than the last 10 or 20
entries. I wanted a fairly large, historical data set of RSS feeds from a
variety of services but was unable to find any freely available collections of
this sort.

Fortunately, there are a number of libraries out there that make parsing feeds
really easy. Couple these with some of the really nice ORM (object-relational 
mapping) frameworks and presto! My very own SQL database of RSS feeds.

If you need to do something similar, you are more than welcome to use my 
scripts. All I ask is that if you build any interesting collection of RSS feeds
I'd love a quick email letting me know about it.

Requirements
============
Feed Bag is a [ruby][] script that depends on two libraries not found in the
standard libraries that come with the ruby 1.8.6 distribution:

[ruby]: http://ruby-lang.org

*	[Feed Normalizer][]: Parses various RSS and Atom feeds and converts
	the resulting entries into ruby objects that can be easily manipulated.

[feed normalizer]: http://feed-normalizer.rubyforge.org/

*	[Sequel][]: A general, lightweight ORM framework (similar to Rail's
	ActiveRecord) that has a nice DSL for queries and table schema. It
	has adaptors for SQLite, MySQL, Postgres and other databases.

[sequel]: http://sequel.rubyforge.org/

Both libraries are easily installed as [ruby gems][]. These ensure that any
other dependencies are automatically installed. Once you have ruby gems 
installed on your machine, all you need to do is:

	sudo gem install sequel
	sudo gem install feed-normalizer

[ruby gems]: http://www.rubygems.org/

You will also need some SQL database manager to run the script. I've found 
[SQLite][] to be a great database manager for quick and dirty projects like this
one as you don't have to worry about user management, servers and the like.
I am currently using version 3.4.0 for Mac OS X. 

[sqlite]: http://www.sqlite.org/

Installing
==========
Once you have all of the above dependencies, you can do one of two things:

* Download the [feedbag.zip][] file and unpack it. 
* Check it from my [GitHub Feedbag repository][github].

[feedbag.zip]: /files/code/feedbag.zip
[github]: http://github.com/mreid/feed-bag/tree/master

Either way, you will get these three files:

*	`feedbag.rb`: 	The main script.
*	`models.rb`:	Used to define the database schema and operations.
*	`tally,sh`:		A small bash script that calls sqlite to count entries.

Running
=======
There are three main modes of using Feed Bag: _adding_ a new feed, _listing_ the
current feeds, and _scanning_ existing feeds.

All feeds and entries are stored in an SQLite database that is created as 
required. SQLite databases are saved as a single file. All modes of usage must 
specify which SQLite file to use as the database through the use of the `-d`
option.

A complete list of options and brief usage synopsis is available by calling
`feedbag.rb --help`.

Adding a New Feed
-----------------
To add a feed for the [ABC News coverage of Australian news][abc] to a new
or existing database file called `news.db` you just do this at your command
prompt:

	$ ./feedbag.rb -d news.db http://www.abc.net.au/news/indexes/idx-australia/rss.xml
	Using news.db for Feed DB
	Creating new feed for  http://www.abc.net.au/news/indexes/idx-australia/rss.xml
	        The new feed is called 'ABC News : Australia'

If `news.db` does not exist it will be created in the current directory. The 
feed at the given URL will be parsed and stored in the database. However, no
entries from the feed are read at this stage.

Multiple URLs for feeds can be added with one call to `feedbag.rb`.

[abc]: http://www.abc.net.au/news/

Listing Existing Feeds
----------------------
To list the feeds that exist in a given database, their number of entries and
when they were last checked you use the `-l` or `--list` option:

	$ ./feedbag.rb -d news.db -l
	Using news.db for Feed DB
	1: ABC News : Australia (Checked: Thu Jan 01 00:00:00 +1000 1970) - 0

The first number is a unique identifier for the feed, the text after it is its
name as it appears in the parsed RSS feed. Inside the brackets is the date and 
time of the most recently parsed entry in the feed (here it is set to the [Unix 
epoch] as there are no entries yet). The last number is the number of parsed
entries.

[unix epoch]: http://en.wikipedia.org/wiki/Epoch_%28reference_date%29#Computing

Scanning for New Entries
------------------------
A call to `feedbag.rb` with no arguments scans all the existing feeds in the 
database for news entries (_i.e._, those with dates after the currently most
recent one):

	$ ./feedbag.rb -d news.db
	Using news.db for Feed DB
		
	Scanning ABC News : Australia
	        Budget cuts force Centrelink to axe 2,000 jobs
	        Tripodi facing suspension over Scimone probe
	        Iemma promises crackdown on donations
			[... 20 more titles ...]
	        Nuclear energy not yet an option: Wong

The output here shows the titles of each of the entries that were parsed and
added to the database.

Listing the contents of the database now shows the following:

	$ ./feedbag.rb -d news.db -l
	Using news.db for Feed DB
	1: ABC News : Australia (Checked: Fri Feb 22 16:39:00 +1100 2008) - 24

Uses
====
Feed Bag does not provide any more support over scanning and archiving entries
from RSS feeds when called. To periodically check for new entries in you will
have to set up a `crontab` or `launchd` item or some other script to 
periodically call `feedbag.rb`.

Once you have collected some data it's up to you what you do with it. The 
easiest way to start processing it is via SQL. For example, if you wanted to
count the number of entries in each feed you can use SQL like this:

	 $ sqlite3 news.db "select name, count(*) from feeds, entries where entries.feed_id = feeds.id group by feed_id;"
	ABC News : Australia|24
	
This is effectively what the `tally.sh` script does. Alternatively, you could
also write more powerful analysis scripts using ruby and the Sequel framework
(it's really, really slick!)

The database schema used by Feed Bag is concisely summarised in the Sequel 
domain-specific language. It is found in the `models.rb file`. The feeds:

	class Feed < Sequel::Model(:feeds)
	  set_schema do
	    primary_key   :id
	    text          :name
	    text          :url
	    time          :last_checked
	    time          :created
	  end

And the entries:

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

Even if you don't precisely understand what Sequel is doing here it's pretty 
clear what the tables and columns are if you know a little SQL.

Feedback
========
If you end up using Feed Bag, I'd love to hear about it -- especially if you 
create a useful data set with it. 

You can email me usingthe link at the bottom of this page, or leave me a comment
at my blog: _[inductio ex machina][]_.

[inductio ex machina]: http://conflate.net/inductio/
