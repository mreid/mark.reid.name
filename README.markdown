Mark.Reid.name
==============

This repository **contained** the source for my personal site at <http://mark.reid.name> up until early 2013. After then I [switched from Jekyll to Hakyll][switch].

My site's new repository is now here: https://github.com/mreid/markreidname-hakyll

[switch]: http://mark.reid.name/blog/switching-to-hakyll.html

IMPORTANT!
===========
I am very happy for others to use my design as a basis for their own site but PLEASE ensure you delete all my _content_ (i.e., pages, blog posts, etc) before uploading your version to the web.

Be especially careful with some of the dynamic content and javascript I use on my pages, particularly:

* Disqus comments on blog posts - These are hard coded to my Disqus account. If you just copy and paste my templates I will be the moderator of your blog's comments. You don't want that. If you don't know how to set up your own Disqus account please remove the Javascript from the bottom of the `_layouts/iem-post.html` and `_layouts/sap-post.html` files.

* Google analytics - My personal Google analytics code is hard-coded into the `_layouts/default.html` template which every page inherits from. If you do not remove or change the Javascript at the bottom of this template all your site's traffic will be counted as mine. You don't want that.

* Twitter, LibraryThing and Delicious feeds - The front page pulls in my tweets and recent reads. The "Links" page for my IEM blog pulls in my bookmarks. You will want to change these or remove them for your own site.

Basically, the rules are these: 

* _If you don't understand it or didn't write it then remove it_. 
* _Test your site on a local machine before you upload your site_. 

Thanks.

License
=======

Unless otherwise attributed, all of the content in this repository is released under a Creative Commons ([Attribution-Noncommercial-Share Alike 3.0 Unported](http://creativecommons.org/licenses/by-nc-sa/3.0/) licence.

Usage
=====
I develop the site locally and then rsync the changes to my host as follows:

    rsync -ave ssh ~/Sites/mark.reid.name/ confla@conflate.net:www/name

Thanks
======
A huge thanks to Tom Preston-Werner for creating Jekyll.
