---
title: "Minilight in Clojure: Triangles"

excerpt: This is the second part of my attempt to port the Minilight ray-tracer to Clojure. This time it is triangles. Some bugs are found and fixed in the vector package.  

location: Canberra, Australia
layout: sap-post

---

Previously on "Porting Minilight to Clojure", our intrepid programmer (a.k.a, yours truly) braved lists, cross products and testing suites to bring you a namespace full of [vector][] operations. In this, the nail-biting sequel, I use these to build up some simple geometry in the form of triangles.

Once again, the code is on GitHub, this time tagged with [sap-2][tag] so it is easy to follow and sing along.

[vector]: /sap/minilight-clojure-vectors.html
[tag]: http://github.com/mreid/minilight-clojure/tree/sap-2

House-keeping...
----------------
Thanks to some [feedback][] from the Clojure mailing list, I've made a couple of small changes to the way I've set up this project: 

* I now use of fully qualified names. That is, instead of a package called `vec`, I will use the longer, Java-style `mreid.minilight.vec` to avoid potential name collisions.

* The code now lives under a `src` directory in folders corresponding to their fully-qualified package name. This meant adding a `.clojure` file with the text `src` in it so that my `clj` script can find the code.

* The tests now define a class and are executed via a main method. This is so that IDE users won't have the tests run every time the `test.clj` file is compiled.

Tests are now run from a simple shell script `runtests.sh` which has the following contents:

{% highlight sh %}
#!/bin/bash
JARS=$HOME/Library/Clojure/lib
CP=.:./src:$JARS/clojure.jar:$JARS/clojure-contrib.jar
TEST="src/mreid/minilight/test/all.clj"
MAIN="(mreid.minilight.test.all/-main)"

java -cp $CP clojure.main -i $TEST -e "$MAIN"{% endhighlight %}

[feedback]: http://groups.google.com/group/clojure/browse_thread/thread/3f8283421219fef5/10de2f48fb48f6b8

...and a Bug-Fix
----------------
In the process of writing some new code I found a bug in my cross product implementation. After a bit of head-scratching, I realised that the form I use to extract a particular component from a vector assumes that the underlying data structure is a Clojure vector. I was using this `(v 0)` to get at the x-coordinate of the vector `v` which works fine for `([1 2 3] 1)` but fails spectacularly when the vector is computed as a lazy sequence. For example:

	Clojure
	user=> ((map - [1 2 3] [1 1 1]) 1)
	java.lang.ClassCastException: clojure.lang.LazySeq cannot be cast to
	clojure.lang.IFn (NO_SOURCE_FILE:0)

I used `map` in several places to compute addition, subtraction and scaling of vectors so when these were passed into `cross` they blew up.

I've added some new tests to `test/vec.clj` that test for this situation explicitly:

{% highlight clojure %}
(def dyn100 (sub [1 2 3] [0 2 3]))
(def dyn010 (sub [1 2 3] [1 1 3]))

(deftest test-dynamic-add
  (is (= [1 1 0]  (add dyn100 dyn010))))

(deftest test-dynamic-sub
  (is (= [1 -1 0] (sub dyn100 dyn010))))

(deftest test-dynamic-scale
  (is (= [2 0 0]    (scale 2 dyn100))))

(deftest test-dynamic-cross
  (is (= [0 0 1]   (cross dyn100 dyn010))))
{% endhighlight %}

and changed the definition of `cross` to use the sequence friendly `nth` instead:

{% highlight clojure %}
(defn cross 
    "Returns the cross product vector for the 3D vectors v1 and v2."
    [v1 v2] 
    [ (- (* (nth v1 1) (nth v2 2)) (* (nth v1 2) (nth v2 1)))
      (- (* (nth v1 2) (nth v2 0)) (* (nth v1 0) (nth v2 2)))
      (- (* (nth v1 0) (nth v2 1)) (* (nth v1 1) (nth v2 0))) ])
{% endhighlight %}

I guess this is one of those instances where static typing would have helped me realise my mistake earlier.

Triangles
---------
Triangles are the simplest possible polygon. They are defined by three vectors, one for each vertex. As we will be using triangles to model surfaces in a ray-tracer, I will also need two other vectors to define how light is reflected and emitted from a surface. In Clojure, this is neatly captured using a `struct`:

{% highlight clojure %}
;; --- mreid/minilight/triangle.clj ---
;; A structure and functions for defining and querying triangles.
(ns mreid.minilight.triangle
  (:use mreid.minilight.vec))
 
(defstruct triangle
  :vertices ; Collection of 3 vectors
  :reflect  ; Vector with all values in [0,1)
  :emit     ; Vector with positive values
)
{% endhighlight %}

To interrogate the structure and calculate related quantities I will also need a number of simple functions:

{% highlight clojure %}
(defn vertex
  "Returns (the zero-indexed) vertex i in the triangle t"
  [t i] (nth (:vertices t) i))

(defn edge
  "Returns the edge in the triangle t from vertex i to vertex j"
  [t i j] (sub (vertex t j) (vertex t i)))

(defn tangent
  "Returns a unit vector tangent to the given triangle t"
  [t] (normalise (edge t 0 1)))

(defn normal
  "Returns a vector normal to the given triangle t (edge01 x edge12)"
  [t] (cross (edge t 0 1) (edge t 1 2)))

(defn unit-normal
  "Returns a unit vector normal to the given triangle t"
  [t] (normalise (normal t)))

(defn area
  "Returns the are of the given triangle t"
  [t] (/ (norm (normal t)) 2))
{% endhighlight %}

This is all very straight-forward and, once again, Clojure just "gets out of the way" and make it very easy to express each of these simple functions on a single line and with a minimum of fuss. Unit tests for these can be found in the file `test/triangle.clj`.

There are three main functions left to port: one that computes a bounding-box for a triangle, one that tests whether a vector intersects a triangle, and one that randomly samples a point from a given triangle.

Bounding Boxes
--------------
The following function creates the smallest box containing all the points belonging to a triangle and then slightly expands it. It is pretty straight-forward, the only slightly tricky part is the higher-order function `tweak`. This takes in either a `+` or a `-` and will return a function that expands or shrinks _its_ input by the specified `TOLERANCE`. This is used by `bounding-box` to pull the point of a triangle closest to the origin about 0.1% closer and push the furthest point away by 0.1%.

The reason for this function is that without it I would have have two copies of the code inside the function returned by `tweak` with only a sign change. I figured this was a more [DRY][] was of writing it.

[dry]: http://en.wikipedia.org/wiki/Don't_repeat_yourself

{% highlight clojure %}
(def TOLERANCE (/ 1.0 1024.0))
(defn tweak
  "Returns a function that adds or subtracts a small amount"
  [add-or-sub]
  (fn [x] (add-or-sub x (* (+ (Math/abs x) 1.0) TOLERANCE))))

(defn bounding-box
  "Computes the bounding box for a triangle t, returning the result as
  a list of two vectors [lower-corner upper-corner]." 
  [t]
  (let [vs (:vertices t)]
    [ (map (tweak -) (apply map min vs))
      (map (tweak +) (apply map max vs)) ]))
{% endhighlight %}

The above code is definitely not the most efficient way of computing and expanding a bounding-box. Indeed, the Ruby code that I'm cribbing this from explicitly optimises this using a single loop through each of a triangle's vectors. In the interests of simplicity, I've opted for more two sweeps through each vector---once for the `min`/`max` and once for the `tweak`.

One discovery I made while attempting to write this was the `apply` method. Its (very terse) documentation says

	clojure.core/apply
	([f args* argseq])
	  Applies fn f to the argument list formed by prepending args to argseq.

In English, what it really does is treat a sequence of items as though they were passed in as arguments to the given function. In my case, I wanted to compute the point-wise minimum of three vectors. If these were, say, `[1 2 3]`, `[0 5 5]` and `[1 1 1]` I would simply `map` `min` onto them as arguments:

	Clojure
	user=> (map min [1 2 3] [0 5 5] [1 1 1])
	(0 1 1)

This works because `min` can take an arbitrary number of arguments (_e.g._, `min 1 0 1` gives 0) and `map`, when given several sequences, will pull items from each in parallel and pass them to the function it is mapping.

However, the problem I faced here was that the three vectors were inside a sequence and so naïvely trying the following gives the wrong result:

	user=> (map min [ [1 2 3] [0 5 5] [1 1 1] ])
	([1 2 3] [0 5 5] [1 1 1])
	
This is where `apply` comes in. It strips away the container and presents its contents to the function being applied as arguments, along with any extra arguments before the sequence:

	user=> (apply map min [ [1 2 3] [0 5 5] [1 1 1] ])
	(0 1 1)

Intersection
------------
Much of the main loop of a ray-tracing algorithm involves 

{% highlight clojure %}
(defn intersect
  "Finds the intersection with the triangle t of the ray starting at r0 in 
  direction rd. The returned value is a positive number a such that r0 + a.rd 
  is contained within t, or nil if there is no such a."
  [t r0 rd]
  (let [ e01    (edge t 0 1)
         e20    (edge t 2 0)
         invdet (invdet e01 rd e20) ]
    (if (number? invdet)
      (let [ v0 (vertex t 0)
             tv (sub r0 v0)
             u  (* (dot v0 tv) invdet) ]
        (if (and (>= u 0) (<= u 1))
          (let [ q (cross tv e01)
                 v (* (dot rd q) invdet) ]
            (if (and (>= v 0) (<= (+ u v) 1))
              (let [a (* (dot e20 q) invdet)]
                (if (>= a 0) a)))))))))
{% endhighlight %}

I'm least happy with the style of this code. The repeatedly nested `let`/`if` blocks seem ugly but I cannot see a more elegant way to do this sort of thing. 

Suggestions on how to improve this function are very welcome.

Sampling
--------

{% highlight clojure %}
(def rnd (java.util.Random.))
(defn sample-point
  "Returns a random point as a vector from inside the given triangle t"
  [t]
  (let [ sqr1 (Math/sqrt (.nextFloat rnd))
         r2   (.nextFloat rnd)
         a    (- 1 sqr1)
         b    (* (- 1 r2) sqr1) ]
    (add (vertex t 0)
        (add (scale a (edge t 0 1)) 
             (scale b (edge t 2 0))))))
{% endhighlight %}
