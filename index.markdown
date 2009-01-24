---
layout: name
title: Home
top: Mark Reid
section: Home
---

<img src="/images/mark_reid.jpg" alt="Photo of Mark Reid drinking coffee" title="Mark Reid" class="inset right" width="120px"/>

Welcome to my personal website. 
I'm currently in the process of transferring over my old site to this new format 
so not all links may work at present.
{: .emphfirst :}

Apologies. I expect to have the site fixed up by mid-February, 2009.

Very briefly, I'm a happily married 30-something with a Ph.D. in machine 
learning who has recently become a dad. 

<!--
<div class="section" markdown="1">
Reading
=======

<script type="text/javascript" src="http://www.librarything.com/jswidget.php?reporton=mdreid&show=recent&header=&num=10&covers=small&text=title&tag=show&css=0&style=2&version=1" ></script>

</div>

  <div class="section">
  <h1>Listening</h1>
  <script type="text/javascript" src="http://last.aelabs.net/js/albums.js?u=mdreid&limit=10"></script>
  </div>
-->

<div class="section" markdown="1">
Research
========
My day job is as a [Research Fellow](/work) in statistical machine learning at 
the Australian National University's Research School of Information Sciences and
Engineering.
</div>

<div class="section">
<h1>Blog</h1>
<p>
I keep a research blog 	called <i><a href="/iem">inductio ex machina</a></i> on 
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
</p>
</div>

<div class="section" id="twitter_div">
  <h1 class="twitter-title"><a href="http://twitter.com/mdreid/">Twitter</a></h1>
  <p>&ldquo;<span id="twitter_update_list">Contacting Twitter...</span>&rdquo;</p>
</div>

