---
layout: sap

title: Home

---

Programming is all about _structure_ and _process_ and this blog is all about
[Mark Reid](/)'s adventures in programming. Enjoy!

My most recent post are:
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
