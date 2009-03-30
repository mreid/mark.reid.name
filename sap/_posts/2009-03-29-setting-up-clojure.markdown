---
title: Setting Up Clojure for Mac OS X Leopard

excerpt: I have recently been experimenting with Clojure and here I document how I have set up my work environment.

location: Canberra, Australia
layout: sap-post

---

[Clojure][] is a fairly new [Lisp-like][], [functional language][] that is [built on top of the JVM][jvm]. It features great Java interoperability and is built from the ground up with [concurrency][] in mind.

[clojure]: http://clojure.org/
[jvm]: http://clojure.org/jvm_hosted
[lisp-like]: http://clojure.org/lisp
[functional language]: http://clojure.org/functional_programming
[concurrency]: http://clojure.org/state

Below is a brief description of how to get Clojure up an running on Mac OS X Leopard. I also describe a small shell script that invokes Clojure and sets its classpath using a simple, project-specific configuration file.

Getting Clojure
---------------

1. Download [clojure 20081217][].

2. Copy `clojure.jar` to the `vendor` directory:    
`$ cp ~/Downloads/clojure/clojure.jar vendor`

[clojure]: http://clojure.org/
[clojure 20081217]: http://clojure.googlecode.com/files/clojure_20081217.zip

### [JLine][] ###

1. Download [jline-0.9.94.zip][].

2. Copy to the `vendor` directory:    
`$ cp ~/Downloads/jline-0.9.94/jline-0.9.94.jar vendor/jline.jar`

[jline]: http://jline.sourceforge.net/
[jline-0.9.94.zip]: http://downloads.sourceforge.net/jline/jline-0.9.94.zip

Put the Clojure jar, JReadLine jars and clojure.contrib libraries in `~/Library/Clojure/lib`.

Created a bash script called `clj` in `~/Library/Frameworks/Clojure` that sets up the classpath. If it is present, this script adds the contents of a `.clojure` to the classpath before executing Clojure.

(Part of these instructions were inspired by this [tutorial][])

[tutorial]: http://lifeofaprogrammergeek.blogspot.com/2009/03/learning-clojure-and-emacs.html

Building clojure-contrib
------------------------
This step is optional. You only need to do it if you wish to use some of the extra, community-contributed Clojure libraries. 

This step also requires [git][] which is not a standard part of OS X Leopard but a simple [OS X installer][] is available.

[git]: http://git-scm.com/
[os x installer]: http://code.google.com/p/git-osx-installer/

Once you have git installed, you can get the current version of the contributed libraries like so:

	$ git clone git://github.com/kevinoneill/clojure-contrib.git

Now build the jar file using `ant` and copy it to the Clojure directory:

    $ cd clojure-contrib
	$ ant -Dclojure.jar=$HOME/Library/Clojure/lib/clojure.jar
	$ cp clojure-contrib.jar ~/Library/Clojure/lib/

Invoking Clojure
----------------

{% highlight bash %}
JAVA=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/bin/java 
CLJ_DIR=$(dirname $0)
CLOJURE=$CLJ_DIR/clojure.jar
JLINE=$CLJ_DIR/jline.jar
CP=$CLOJURE:$JLINE

# Add extra jars as specified by `.clojure` file
if [ -f .clojure ]
then
	CP=$CP:`cat .clojure`
fi

if [ -z "$1" ]; then 
	$JAVA -server -cp $CP \
	    jline.ConsoleRunner clojure.lang.Repl    
else
	scriptname=$1
	$JAVA -server -cp $CP clojure.lang.Script $scriptname -- $*
fi
{% endhighlight %}

