This is the data for my personal website
========================================

It is automatically transformed by [Jekyll](http://github.com/mreid/jekyll) 
(a fork of mojombo's original version)
into a static site whenever I push this repository to GitHub.

License
=======

The following directories and their contents are Copyright Mark Reid. 
You may not reuse anything therein without my permission:

* _posts/
* images/

All other directories and files are MIT Licensed. 
Feel free to use the HTML and CSS as you please. If you do use them, a link back to <http://mark.reid.name> would be appreciated.

Usage
=====
I develop the site locally and then rsync the changes to my host as follows:

    rsync -ave ssh ~/Sites/mark.reid.name/ confla@conflate.net:www/name

Thanks
======
A huge thanks to Tom Preston-Werner for creating Jekyll.