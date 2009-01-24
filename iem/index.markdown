---
layout: iem
title: Home
section: Home

feed: atom.xml
keywords: Machine Learning, Statistics, Blog, Research, Academia
---

Thoughts on Machine Learning and Inference {: .emphnext :}
==========================================

This is _Inductio Ex Machina_, [Mark Reid](/)'s research blog on machine 
learning and statistical inference.

You can browse through the complete archives [here](past.html). 

Recent Posts
------------

{% for post in site.categories.iem limit:5 %}
<div class="section list">
  <h1>{{ post.date | date_to_string }}</h1>
  <p class="line">
  <a class="title" href="{{ post.url }}">{{ post.title }}</a>
  <a class="comments" href="{{ post.url }}#disqus_thread">View Comments</a>
  </p>
  <p class="excerpt">{{ post.excerpt }}</p>
</div>
{% endfor %}

<p>
<a href="past.html">Older Posts &rarr;</a>
</p>
<!--
  <ul class="posts">
    {% for post in site.categories.work %}	  
      <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a><br/>
	  <span class="excerpt">{{ post.excerpt }}</span>
	  </li>
    {% endfor %}
  </ul>
-->

<script type="text/javascript">
//<![CDATA[
(function() {
		var links = document.getElementsByTagName('a');
		var query = '?';
		for(var i = 0; i < links.length; i++) {
			if(links[i].href.indexOf('#disqus_thread') >= 0) {
				query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
			}
		}
		document.write('<script type="text/javascript" src="http://disqus.com/forums/markreid/get_num_replies.js' + query + '"></' + 'script>');
	})();
//]]>
</script>
