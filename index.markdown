---
layout: name
title: Home

section: Home
---

<img class='inset right' src='/images/mark_reid.jpg' title='Mark Reid' alt='Photo of Mark Reid drinking a coffee' width='120px' />

Welcome
=======

I'm Mark Reid, a 30-something Australian, academic, husband, programmer, father, 
snowboarder, and web-nerd---amongst other things. You can find out more about 
be by poking around the links above and below.

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
[Twitter](http://twitter.com/mdreid)
====================================

Contacting Twitter... 
{:#twitter_update_list }

=--
