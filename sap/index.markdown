---
layout: sap
title: Home
section: Home

feed: atom.xml
keywords: Blog, Programming, Clojure
---

Programming Lab Notes
=====================

Programming is all about _structure_ and _process_ and this blog is all about
[Mark Reid](/)'s adventures in programming. Enjoy!

[![Feed icon](/files/css/feed-icon-14x14.png){:title="Atom feed of recent posts" .right}][feed]
A [feed][] of the most recent posts is available.

[feed]: /sap/atom.xml

Recent Posts
------------

{% for post in site.categories.sap limit:5 %}
<div class="section list">
  <h1>{{ post.date | date_to_string }}</h1>
  <p class="line">
  <a class="title" href="{{ post.url }}">{{ post.title }}</a>
  <a class="comments" href="{{ post.url }}#disqus_thread">View Comments</a>
  </p>
  <p class="excerpt">{{ post.excerpt }}</p>
</div>
{% endfor %}

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
		document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/structure-and-process/get_num_replies.js' + query + '"></' + 'script>');
	})();
//]]>
</script>
