--- 
layout: iem-post
title: A Meta-index of Data Sets
location: Canberra, Australia

excerpt: A collection of sites around the web that catalogue a wide variety of data sets that may be useful to machine learning researchers.

wordpress_id: 26
wordpress_url: http://conflate.net/inductio/application/a-meta-index-of-data-sets/

---
I had to go hunting around for some data to try some new ideas on recently.
As [handy][google] as Google is, there's still a fair bit of 
chaff from which to sort the wheat.  

[google]: http://google.com/search?q=machine+learning+data+sets

Fortunately, there is a lot of good stuff out there including well-organised
indexes of data sets for various purposes. For my future reference (and for
anyone else that may be interested) here are some of the better data set lists
I found.

*	**UCI Repositories**:
	No list of lists would be complete without this perennial [collection][uci]
	of machine learning data sets hosted by the University of California, 
	Irvine. They also have a [repository of large data sets][kdd] for 
	knowledge discovery in databases (KDD).

[kdd]: http://kdd.ics.uci.edu/
[uci]: http://archive.ics.uci.edu/ml/

*	**The Info**: 
	This [site][theinfo] "for people with large data sets" has a community
	editable [list of data sets][theinfo_data] organised by topic. The 
	collection here has a web/text focus.

[theinfo]: http://theinfo.org
[theinfo_data]: http://theinfo.org/get/data

*	**Text Retrieval**:
	This [list][trec] kept by NIST has data sets for each of the various
	tracks at the Text Retrieval Conference, including data sets for 
	[spam detection](http://trec.nist.gov/data/spam.html),
	[genomics](http://trec.nist.gov/data/genomics.html),
	and a [terabyte](http://trec.nist.gov/data/terabyte.html) track
	(although the data sets aren't quite up to a terabyte yet).

[trec]: http://trec.nist.gov/data.html

*	**Time Series Data Library**:
	This [collection][tsdl] has a large number of time varying data sets from
	finance, demography, physics, sport and ecology. 

[tsdl]: http://www-personal.buseco.monash.edu.au/~hyndman/TSDL/

*	**DMOZ Directory of Data Sets**:
	This is a good [starting point][dmoz] for more lists of data sets for 
	machine learning.
	
	Parts of DMOZ itself are [available in RDF][dmoz_data] as a data set for 
	researchers. There is also a [processed version][dmoz_processed] made
	available as part of the PASCAL [Ontology Learning Challenge][olc].

[dmoz]: http://www.dmoz.org/Computers/Artificial_Intelligence/Machine_Learning/Datasets/
[dmoz_data]: http://rdf.dmoz.org/
[dmoz_processed]: http://olc.ijs.si/dmozReadme.html
[olc]: http://olc.ijs.si/

*	**Royal Statistical Society**:
	This [collection][rss_data] contains data sets used in research published in 
	the [journal of the Royal Statistical Society][rss]. This is an admirable
	idea that I wish more journals would take up.

[rss_data]: http://www.blackwellpublishing.com/rss/ 
[rss]: http://www.rss.org.uk/ 

As well as the above institution or community organised lists, I also came 
across some maintained by individuals.

*	**Daniel Lemire**: 
	Daniel Lemire's "[Data for Database Research][lemire]" is organised by 
	application areas, including data for earthquakes, weather, finance, climate 
	and blogs.

[lemire]:  http://www.daniel-lemire.com/blog/data-for-data-mining/

*	**Peter Skomoroch**:
	The [list of data sets][skomoroch] over at [Data Wrangling][data_wrangling] 
	is similar in spirit to the one here.

[skomoroch]: http://www.datawrangling.com/some-datasets-available-on-the-web.html
[data_wrangling]: http://www.datawrangling.com/

A few specific data sets caught my eye, some new, and some I just hadn't seen 
before.

*	**Freebase Wikipedia Extraction**:
	The [Wikipedia WEX][wex] data set is 
	essentially a large (57 GB) graph of articles from wikipedia. 

[wex]: http://download.freebase.com/wex/
	
*	**Enron Email**:
	This [collection of email][enron] (400 Mb compressed) between Enron staff 
	contains about half a million messages organised into folders. It was
	released publicly as part of the investigation into Enron and has been
	used by William Cohen and others as part of the CALO project.

[enron]: http://www.cs.cmu.edu/~enron/

*	**Freeway Traffic Analysis**:
	This fairly [large data set][freeway] is a record of traffic flow on
	several lanes of the I-880 freeway in California in order to study the
	effect of roving tow-trucks on dealing with decongesting traffic 
	incidents.

[freeway]: http://ipa.eecs.berkeley.edu/~pettyk/FSP/

If all else fails and you still cannot find a suitable data set for your 
research, you can always invoke the social web and trawl through bookmarks
on services like [del.icio.us](http://del.icio.us). The global 
[data set tag][global_tag] can throw up some interesting hits occasionally but
there might be a higher wheat to chaff ratio in particular user's bookmarks,
such as [Peter Skomoroch][skomoroch_tag]. [Mine][] is not nearly as 
comprehensive yet.

[global_tag]: http://del.icio.us/tag/dataset
[skomoroch_tag]: http://del.icio.us/pskomoroch/dataset
[mine]: http://del.icio.us/mreid/dataset

It would be interesting to do a meta-analysis of all these data sets to see how
our ability as a discipline to deal with larger and more complex data sets has
increased over time. As Daniel Lemire pointed out with some surprise recently,
[processing a terabyte of data][small_terabyte] isn't that uncommon.

[small_terabyte]: http://www.daniel-lemire.com/blog/archives/2008/02/21/when-a-terabyte-is-small/
