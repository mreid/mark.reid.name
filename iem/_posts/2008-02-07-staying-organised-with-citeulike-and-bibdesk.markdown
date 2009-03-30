--- 
layout: iem-post
title: Staying Organised with CiteULike and BibDesk
location: Canberra, Australia

excerpt: An overview of how I use the free Mac application BibDesk along with the online social bibliographic service CiteULike.

wordpress_id: 24
wordpress_url: http://conflate.net/inductio/reading/staying-organised-with-citeulike-and-bibdesk/

---
I recently started using [CiteULike][] to keep track of papers I read. For those not familiar with it, it deems itself to be "a free online service to organise your academic papers". In contrast to my offline bibliography organising tool, [BibDesk][], a service like this has at least three main advantages:

* Reduced data entry: If someone else has already entered the article's details or CiteULike can scrape them of a journal's web page I don't have to enter them myself.

* Easy access: The bibliography is stored on the web making access away from my machine or by others straightforward. It's also possible to upload copies of papers for personal use in case you're not able to get to your university's reverse proxy. 

* Social networks: When I see that someone else has read a paper I'm interested in I can easily see what else that person has read. I can also look at all the other papers that people have associated with a particular tag. 

Like Yaroslav, who also uses CiteULike as part of his [larger strategy][yaroslav] for staying organised, I have started using the Notes field for entries to keep track of important theorems, equations and cross-references of papers that I go over more than once. 

Of course, once you've collected a bunch of papers you can also export your bibliography as BibTeX or RIS so your can include citations in your papers. This is especially convenient with BibDesk. All I do is open a "New External File Group" in BibDesk and point it to the URL for my CiteULike account: `http://www.citeulike.org/bibtex/user/mdreid`. BibDesk keeps track of which external entries have or haven't been imported into your offline BibTeX file making it easy to quickly build a conference specific bibliography.

I find this BibDesk and CiteULike combination the best of both worlds as it reduces the amount of data entry I need to do while still making it easy to push citations to [TextMate][] or [LyX][] when I'm writing.

[citeulike]: http://citeulike.org/user/mdreid
[bibdesk]: http://bibdesk.sourceforge.net/
[yaroslav]: http://yaroslavvb.blogspot.com/2008/02/strategies-for-organizing-literature.html
[textmate]: http://macromates.com/
[lyx]: http://www.lyx.org/
