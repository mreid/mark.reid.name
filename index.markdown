---
layout: name
title: Home

section: Home
---

![Photo of Mark Reid drikning coffee](/images/mark_reid.jpg){:.inset .right width="120px" :}

Welcome to my personal website. 
I'm currently in the process of transferring over my old site to this new format 
so not all links may work at present.
{: .emphfirst :}

Apologies. I expect to have the site fixed up by mid-February, 2009.

Very briefly, I'm a happily married 30-something with a Ph.D. in machine 
learning who has recently become a dad. 

+--	{.section}
Research
========
My day job is as a [Research Fellow](/work) in statistical machine learning at 
the Australian National University's Research School of Information Sciences and
Engineering.
=--


+-- {.section}
Blog
====
I keep a research blog 	called _[inductio ex machina](/iem)_ on 
machine learning and statistics.
Recent posts include:
{% for post in site.categories.iem limit:3 %}
<ul class="compact">
<li>
	<span class="date">{{ post.date | date_to_string }}</span> 
	&nbsp;&mdash;&nbsp;
	<a href="{{ post.url }}" title="{{ post.excerpt }}">{{ post.title }}</a>
</li>
</ul>
{% endfor %}
=--

+-- {.section}
[Reading](http://librarything.com/home/mdreid)
==============================================

<script type="text/javascript" src="http://www.librarything.com/jswidget.php?reporton=mdreid&show=recent&header=&num=8&covers=small&text=title&tag=show&css=0&style=2&version=1" ></script>
=--

+-- {.section}
[Listening](http://last.fm/user/mdreid)
=======================================
<div id="lastfm"><img height="50" width="0" /></div>

<script type="text/javascript" src="/files/js/jquery.js"></script>
<script type="text/javascript" src="/files/js/lastfm.js"></script>

=--

+-- {.section}
[Twitter](http://twitter.com/mdreid)
====================================

Contacting Twitter... 
{:#twitter_update_list }

=--
