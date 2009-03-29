---
title: Setting Up Clojure

excerpt: I have recently been experimenting with Clojure and here I document how I have set up my work environment.

location: Canberra, Australia
layout: post

---

Put the Clojure jar, JReadLine jars and clojure.contrib libraries in `~/Library/Frameworks/Clojure`.

Created a bash script called `clj` in `~/Library/Frameworks/Clojure` that sets up the classpath. If it is present, this script adds the contents of a `.clojure` to the classpath before executing Clojure.

(**How do I set up clojure.contrib?**)

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

