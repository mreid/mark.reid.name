---
title: ICML 2010 Discussion Site

excerpt: Some advertising for the revamped ICML discussion site I built.

location: Canberra, Australia

layout: iem-post

---
[ICML 2010][icml2010] is already underway so I thought I would quickly mention the new [discussion site][mldiscuss] I built for it. I'd like for the new version to improve on the earlier ones in terms of participation so, if you haven't done so already, head over to [ML Discuss][mldiscuss] and start discussing!

This is the third year I have set up such a discussion site for ICML. The [previous two years][conflate] were built upon a [wiki engine][dokuwiki] with a [plugin][] that allows comments to be left on wiki pages. This worked fairly well but had one major drawback: it was not easy to be notified when someone commented on your paper or added to a discussion you had participated in. [John][] and I talked about this after the last ICML and agreed that better notifications should be a priority for future discussion sites like this.

To address this, I built the [new site][mldiscuss] from scratch and "outsourced" the comment system to [Disqus][]. The Disqus service allows anyone to put a comment thread on any webpage by adding a small piece of Javascript. Once this is done, all the comment moderation, user management, notifications, and RSS feeds are all handled through the Disqus interface. While, in a sense, this sort of stuff is "trivial" it requires a lot of care to set up the infrastructure correctly and keep it running so I was glad not to have to do that myself.

The rest of the site -- parsing, managing and serving the ICML paper and author information -- is a few simple python scripts running on top of Google [AppEngine][]. Along with [Bosco][], I've used this combination of AppEngine and Disqus before for a similar service called [annotatr][] for commenting on articles in [CiteULike][]. The development environment for AppEngine is great, allowing you to test everything locally, and deploy with literally the push of a button. I would recommend this approach to anyone wishing to set up a discussion site.

As an aside, while building ML Dicsuss I realised this quick and dirty style of development epitomises what Noble and Biddle call _scrap-heap programming_ in Section 13 of their _[Notes on Postmodern Programming][pomo]_[^1]: exploiting the "large number of existing programs that the postmodern programmer can scavenge through and reuse". Now that more and more programs exist as [services][] on the web I think we will see more of this style of development in the future.
 
Happy [discussing][mldiscuss]!

[services]: prediction-services.html
[citeulike]: http://citeulike.org/
[annotatr]: http://annotatr.appspot.com/
[mldiscuss]: http://mldiscuss.appspot.com/
[pomo]: http://plg.uwaterloo.ca/~migod/846/papers/pomo-oopsla02.pdf
[disqus]: http://disqus.com
[appengine]: http://code.google.com/appengine/docs/whatisgoogleappengine.html
[icml2010]: http://www.icml2010.org
[conflate]: http://conflate.net/icml/
[bosco]: http://boscoh.com/
[dokuwiki]: http://dokuwiki.org/
[plugin]: http://www.dokuwiki.org/plugin:discussion
[john]: http://hunch.net/

[^1]: Just for fun, see if you can guess what part of this paper that I quoted in my wedding speech.