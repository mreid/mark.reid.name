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

The first step is to create a Clojure directory in your Library folder that contains the subfolder `lib`. Do this at your Terminal:

	$ mkdir -p ~/Library/Clojure/lib
	$ cd ~/Library/Clojure

Getting Clojure
---------------

The latest stable version of Clojure can be found [here][dlclj]. At the time of writing the latest stable version is the zip file for [Clojure release 20090320][clj20090320].

Once you've downloaded it, copy `clojure.jar` to the `~/Library/Clojure` directory:

	$ cp ~/Downloads/clojure/clojure.jar ~/Library/Clojure/lib/

[clojure]: http://clojure.org/
[dlclj]: http://code.google.com/p/clojure/downloads/list
[clj20090320]: http://clojure.googlecode.com/files/clojure_20090320.zip

To make Clojure's interactive mode easier to you, you should grab the JLine library and install it as well. 

First download [jline-0.9.94.zip][] from the [jline project site][jline] and then:

	$ cp ~/Downloads/jline-0.9.94/jline-0.9.94.jar ~/Library/Clojure/lib/jline.jar

[jline]: http://jline.sourceforge.net/
[jline-0.9.94.zip]: http://downloads.sourceforge.net/jline/jline-0.9.94.zip

Startup Script
--------------

I've created a bash script called `clj` that I put in `~/Library/Clojure` and symbolically link to from somewhere in my path. 

This script sets up the Clojure classpath and, if it is present, also adds the contents of a `.clojure` file to the classpath before executing Clojure. It also adds the current directory to the classpath for ease of use.

You can [download the script][clj] from my [GitHub repository][github]. Once you've got it, copy it to the Clojure directory and make it executable:

	$ cp ~/Downloads/clj ~/Library/Clojure/
	$ chmod u+x ~/Library/Clojure/clj

Now you will want to symbolically link to it from a directory in your `$PATH` Type `echo $PATH` at the Terminal to see a list of options. I have a directory `~/bin/` where I keep such things.

To make the link use, for example:

	$ ln -s ~/Library/Clojure/clj ~/bin/clj

Now I can type `clj` from any directory and see:

	$ clj
	Clojure
	user=> (= (* 6 8) 42)
	false
	user=>

I can also run Clojure programs. For example, suppose I have the following file called `test.clj` in the current directory:

{% highlight clojure %}
(println "Hello, world!")
{% endhighlight %}

Then, when I run the following, I see:

	$ clj test.clj
	Hello, world!
	
[clj]: http://github.com/mreid/clojure-framework/blob/e1c80cc650f448713243be8272dba1fa3c1a7cea/clj
[github]: http://github.com/mreid/clojure-framework/tree

Extending the Classpath
-----------------------
If you need any project-specific jar files added to the classpath when running Clojure, this can be done by putting a `.clojure` file in the same directory you will be running the project from.

For example, suppose I have a program `~/code/cafe/macchiato.clj` that requires class from the Java libraries `grinder.jar` and `frother.jar` in the `~/code/cafe/lib/` directory. 

I can easily create a file `.clojure` that specifies where Clojure can find these extra libraries:

	$ cd ~/code/cafe
	$ echo "lib/grinder.jar:lib/frother.jar" > .clojure

Then when I run:

	$ clj macchiato.clj

from the `~/code/cafe` directory, the earlier `clj` script will pick up the extra jar files from the `.clojure` file and add them to the classpath before invoking Clojure.

Installing and Using clojure-contrib
------------------------------------
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

Now you should be able to use things like Stuart Sierra's library. For example, suppose I was writing a simple vector library called `vec.clj` and wanted to put the following tests in `test.clj` in the same directory:

{% highlight clojure %}
(ns test 
	(:require vec)
	(:use clojure.contrib.test-is))
	
(deftest test-cross-product
	(is (= [-3 6 -3] (vec/cross [1 2 3] [4 5 6])))
	(is (= [0 0 1]   (vec/cross [1 0 0] [0 1 0]))))
	
(run-tests)
{% endhighlight %}

Then, because the `clojure-contrib.jar` is on the classpath, I can run and see the following:

	$ clj test.clj
	
	Testing test

	Ran 1 tests containing 2 assertions.
	0 failures, 0 errors.

Success!

Editing
-------
I use [TextMate][] as my Clojure editor along with the [Clojure bundle][] created by [nullstyle][]. 

It's probably overkill for what I need since that bundle includes a working installation of Clojure (_i.e._, it doesn't call the `clj` I discuss here). I edit in TextMate and then run sessions and scripts from the Terminal. All I'm really taking advantage of is the syntax-highlighting, auto-formatting and the online help (`^H`).

There are other options around such as Clojure modes for Vim and Emacs but I haven't tried them.

[textmate]: http://macromates.com/
[clojure bundle]: http://github.com/stephenroller/clojure-tmbundle/tree/master
[nullstyle]: http://nullstyle.com/

In Closing
----------
I wrote these notes mainly to document the sometimes frustrating processes of getting a flexible, easy-to-use Clojure environment set up. The "[Getting Started][]" page at the main [Clojure][] site are great for getting a REPL up and running but didn't help me at all when it came to using other jars and clojure-contrib. Of course, if I'm doing something here that is patently stupid, please let me know in the comments. 

I keep a shorter version of these notes with more concise step-by-step instructions at the [GitHub repository][github] for this set up.

Hopefully, this short introduction will make it easier for others to get up and running with this great new language.

[getting started]: http://clojure.org/getting_started

Updates
-------
* _1 April 2009_: Added notes about the editor I use and link to my Github repository.

* _4 August 2009_: Fixed some incorrect paths in the instructions.