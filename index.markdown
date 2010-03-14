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
Blogs
=====
I keep a research blog called _[Inductio ex Machina](/iem)_ on 
machine learning and statistics.
Recent posts include:
{% for post in site.categories.iem limit:3 %}
<ul class="compact recent">
<li>
	<a href="{{ post.url }}" title="{{ post.excerpt }}">{{ post.title }}</a>
	<span class="date">{{ post.date | date_to_string }}</span> 
</li>
</ul>
{% endfor %}
=--

+--{.section}
I have also just started a programming blog called _[Structure & Process](/sap)_.
{% for sappost in site.categories.sap limit:3 %}
<ul class="compact recent">
<li>
	<a href="{{ sappost.url }}" title="{{ sappost.excerpt }}">{{ sappost.title }}</a>
	<span class="date">{{ sappost.date | date_to_string }}</span> 
</li>
</ul>
{% endfor %}
=--

+-- {.section}
[Twitter](http://twitter.com/mdreid)
====================================

Contacting Twitter... 
{:#twitter_update_list }

=--

+-- {.section}
[Reading](http://librarything.com/home/mdreid)
==============================================

<script type="text/javascript" src="http://www.librarything.com/jswidget.php?reporton=mdreid&show=recent&header=&num=8&covers=small&text=title&tag=show&css=0&style=2&version=1"> </script>
=--
