Mark.Reid.name
==============

This repository contains the source for my personal site at <http://mark.reid.name>.

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