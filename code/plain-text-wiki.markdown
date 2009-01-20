---
layout: name
section: Code
title: Plain Text Wiki
---
Plain Text Wiki {: .emphnext :}
===============
I really liked the idea of Matt Webb's [Plain Text Wiki][1], the wiki you run 
inside TextMate. So much so, that I wanted to use it to manage one of my
[websites](http://rsise.anu.edu.au/~mreid/). To do so I had to add to tweak a
few things and, after one thing led to another, I ended up with a fairly major
rewrite that added several new features including syntax highlighting, 
the use of Maruku (a Markdown extension) as a page format, subdirectories, 
ERB for templating, and named links.

I've already started to factor out the wiki side of things from the TextMate
interaction and will hopefully turn the wiki-only code into a gem one day. 

[1]: http://interconnected.org/home/2007/05/20/plain_text_wiki

New Features
============

**Maruku**
:	As well as Markdown and Textile, pages can be rendered using [Maruku][], 
	an extension of Markdown that adds footnotes and attributes to markup.

**Subdirectories**
:	Pages can live in subdirectories and are linked to using 
	<code>&#91;&#91;subdir/name&#93;&#93;</code> style links and are
	relative to the page they are found on. To add links to pages in other
	parts of your wiki use absolute paths 
	<code>&#91;&#91;/subdir/name&#93;&#93;</code>.

**Named links**
:	Can use <code>&#91;&#91;pagelink | link text&#93;&#93;</code> to 
	use `link text` instead of link name when exporting to HTML. Names
	can be used for plain, relative and absolute links.

**ERB for templates**
:	Templates can include `<%= property %>` to include page properties.
	Currently, these include `title`, `modified`, `name`, `path_to_root`
	and `section_list`.

**Page titles can be overriden**
:	Use HTML comments at very start of page. 
	e.g., `<!-- title = My new page title -->`.

[maruku]: http://maruku.rubyforge.org


Install
=======

1. Download the zipped [Plain Text Wiki Bundle][bundle] and unzip it.
2. Double-click on the resulting bundle and TextMate will start using it.

To use Maruku as the page format you will have to install it as a ruby gem:
    
    sudo gem install maruku

and make sure that TextMate is using the same version of ruby as the 
command-line does. To do so, just follow the instructions over at 
[blog.dnite.org][environment] and you should be good to go.

[bundle]: /files/code/Plain%20Text%20Wiki.tmbundle.zip
[environment]: http://blog.dnite.org/2007/8/28/textmate-and-your-environment-variables

Configure
=========

The following environment variables can be set from within TextMate
to control the behaviour of the wiki.

`WIKI_PAGE_FORMAT`
:	The default page format. One of `maruku`, `markdown` or `textile`.
	If this environment variable is not set `maruku` is used.

`WIKI_TEMPLATE_DIR`
:	Where to look to find `header.rhtml` and `footer.rhtml`. Defaults to 
	`TM_BUNDLE_SUPPORT/templates`

`WIKI_EXPORT_EXCLUDE`
:	Comma separated list of directories to exclude from export.

Use
===
Open TextMate then choose `Bundles > Plain Text Wiki > Create New Wiki...` and
select a directory for your wiki. 

A new index page will be created. Follow wiki links by hitting the enter key 
(&#x2305;) to make new pages.

To export your wiki choose `Export Wiki as HTML...` from the Plain Text Bundle
menu (or just press &#x21E7;&#x2318;H). You will be asked to choose a destination
directory. Once that is done a HTML version of your wiki will be opened in 
Safari. 

(Note: Currently, exporting only works properly if you call the command while an 
active file is from the wiki's top-level directory).