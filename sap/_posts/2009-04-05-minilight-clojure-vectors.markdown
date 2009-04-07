---
title: "Minilight in Clojure: Vectors"

excerpt: In an attempt to learn Clojure I am translating the minilight ray-tracer. In this first part I build and test a simple 3D vector package.  

location: Canberra, Australia
layout: sap-post

---

Now that I am happy with my Clojure [set up][], it is time to dive in and try to implement something using it. As it happens, I recently discovered the [minilight][] project which aims to implement a "minimal global illumination renderer" in several languages including Ruby, Python, Java, Scala, and C++. I've dabbled with 3D graphics in the past and since there is currently no implementation[^1] in Clojure I thought porting minilight to Clojure would be a great way to start.

In this first part, I'll describe how I ported the Vector3fc class from the Ruby version of minilight. I am keeping all my code for this project over at [GitHub][]. The code I'll be talking about here is tagged '[sap-1][tag]'.

I'm going to assume you have a basic familiarity with Clojure. Skimming over this overview of the [Clojure syntax][] would be a good place to start.

[^1]: Shortly after starting my port of minilight I discovered that [someone else][fatvat] had the same idea and is at about the same stage. It will be interesting to compare our respective approaches as time goes on, and I cannot promise that I won't borrow an idea or two.

[set up]: /sap/setting-up-clojure.html
[minilight]: http://www.hxa.name/minilight/
[clojure]: http://clojure.org/
[fatvat]: http://www.fatvat.co.uk/2009/04/implementing-minilight-in-clojure-2.html
[github]: http://github.com/mreid/minilight-clojure/
[tag]: http://github.com/mreid/minilight-clojure/tree/sap-1
[clojure syntax]: http://ociweb.com/jnb/jnbMar2009.html#Syntax

100 Functions on One Data Structure
-----------------------------------
Vector manipulation is central to any 3D rendering code and Minilight is no exception. In object-oriented languages like Java, Ruby, Python and C++, the general practice is to create a new class for vectors and define methods for their manipulation.

It is possible to do OO programming in LISP-like languages like Clojure but it is not idiomatic. As Alan Perlis put it:

> It is better to have 100 functions operate on one data structure 
> than 10 functions on 10 data structures.

So I've instead opted for defining a namespace `vec` along with a number of operations that treat lists of numbers as vectors and all live in the file `vec.clj`.

{% highlight clojure %}
;; --- vec.clj ---
;; A simple vector package that defines functions for working with geometrical 
;; vectors.
(ns vec)

; Constants
(def origin [0 0 0])    ; Zero vector in 3D
(def epsilon 0.000001)  ; Tolerance for equality

; Helper functions
(defn approx0 
    "Returns true iff the value x is within epsilon of 0"
    [x] (< (Math/abs x) epsilon))

(defn clamp
    "Constrains all elements in v to be between vmin and vmax"
    [vmin vmax v] (map (fn [x] (max vmin (min vmax x))) v))

; Binary operators
(defn dot 
    "Returns the value of dot product of the vectors v1 and v2"
    [v1 v2] (reduce + (map * v1 v2)))
    
(defn add 
    "Returns a vector that is the sum of the vectors v1 and v2"
    [v1 v2] (map + v1 v2))
    
(defn sub 
    "Returns a vector that when added to v1 gives v2"
    [v1 v2] (map - v1 v2))

(defn cross 
    "Returns the cross product vector for the 3D vectors v1 and v2."
    [v1 v2] 
    [ (- (* (v1 1) (v2 2)) (* (v1 2) (v2 1)))
      (- (* (v1 2) (v2 0)) (* (v1 0) (v2 2)))
      (- (* (v1 0) (v2 1)) (* (v1 1) (v2 0))) ])

; Scalar operators
(defn scale 
    "Returns the vector that is m times the vector v"
    [m v] (map #(* m %) v))

; Unary operators
(defn norm 
    "Returns the (Euclidean) length of the vector v"
    [v] (Math/sqrt (dot v v)))

(defn normalise 
    "Returns a vector of unit length in the same direction as v"
    [v] (scale (/ 1 (norm v)) v))

; Determinants
(defn det 
    "Returns the determinant of vectors v1 v2 and v3, i.e. v1.(v2 x v3)"    
    [v1 v2 v3] (dot v1 (cross v2 v3)))

(defn invdet
    "Returns the inverse det. of v1, v2 and v3 or nil if it is too close to 0"
    [v1 v2 v3]
    (let [d (det v1 v2 v3)]
        (if (approx0 d)
            nil
            (/ 1.0 d))))
{% endhighlight %}

The string that appears after a function's name in a `defn` form documents the function. You can view this documentation for any function using the `doc` function. For example, we can see the documentation for `add` like so:

	Clojure
	user=> (use 'vec)
	user=> (doc add)
	-------------------------
	vec/add
	([v1 v2])
	  Returns a vector that is the sum of the vectors v1 and v2

Here are some other observations about how I implemented these functions and some of the Clojure-related tricks I learnt along the way.

* Apart from the function `cross`, all of these definitions are very concise thanks to the use of the higher-order functions `map`, `reduce` and `every?` which apply functions to sequences. Writing the functions this will almost certainly be slower than dealing with arrays of floats but I can always aim to improve efficiency later and thus heed Don Knuth's warning that "premature optimization is the root of all evil (or at least most of it) in programming."

* The function `Math/abs` denotes a call to the static method `abs()` in the class `Math` that comes standard with Java. 

* The form `#(* m %)` in the definition of `scale` is shorthand for `(fn [x] (* m x))`---that is, the function that multiplies its input by `m`. The shorthand is known as a _reader macro_. Clojure expands forms like these into their equivalent long version when it first encounters it.

* The `let` form is Clojure's way of assigning local bindings. The first vector[^2] `[d (det v1 v2 v3)]` binds `d` to the determinant of `v1`, `v2` and `v3`. In general, a `let` can take many pairs of symbol/value bindings like so: `let [a 1 b 2 c3] (...)`. The form after the binding is evaluated in the context of the bindings.

[^2]: This is slightly confusing since Clojure sequences defined using square brackets (e.g., `[1 2 3]`) are called "vectors" after the Java class of the same name.

Testing, testing
----------------
Writing tests for your code is almost always a good idea, especially if most of the code being tested does some kind of number-crunching. Since I plan to rewrite and optimise my vector functions later it is _definitely_ a good idea.

Clojure comes with some built-in support for testing via its [special form][] `:test` which allows tests to sit right next to the code, much like documentation. However, I prefer separating tests into their own files so I've been using [Stuart Sierra][]'s test-is library that comes with the [clojure-contrib][] package. It is a basic unit testing library that allows me to write simple tests for the above vector methods.

[special form]: http://clojure.org/special_forms

Here is a small suite of tests for the vector functions. These appear in the file `test/vec.clj` which means the appropriate namespace is `test.vec`. Note the `:use` form after the definition which imports all the functions in `vec` and the `test-is` library.

{% highlight clojure %}
;; --- test/vec.clj ---
;; Tests for vec.clj using the test-is library.
(ns test.vec
    (:use vec clojure.contrib.test-is))

(deftest test-approx0
    (is (approx0 -0.000000001))
    (is (not (approx0 0.001))))

(deftest test-clamp
    (is (= [1 0 0]       (clamp 0 1 [2 -1 -1])))
    (is (= [0.5 0.5 0.5] (clamp 0 1 [0.5 0.5 0.5]))))

(deftest test-dot
    (is (= 0 (dot [1 1 1] [-1 1 0])))
    (is (= 2 (dot [1 2 3] [3 -2 1]))))

(deftest test-add
    (is (= [1 1 0]  (add [1 1 0] origin)))
    (is (= [-2 3 4] (add origin [-2 3 4])))
    (is (= [1 2 3]  (add [1 -1 2] [0 3 1]))))

(deftest test-sub
    (is (= [1 2 3]  (sub [1 2 3] origin)))
    (is (= [0 0 0]  (sub [1 2 3] [1 2 3])))
    (is (= [-2 0 2] (sub [1 2 3] [3 2 1]))))
    
(deftest test-scale
    (is (= [0 0 0]    (scale 0 [1 2 3])))
    (is (= [-1 -2 -3] (scale -1 [1 2 3])))
    (is (= [2 4 6]    (scale 2 [1 2 3]))))

(deftest test-cross
    (is (= [-3 6 -3] (cross [1 2 3] [4 5 6])))
    (is (= [0 0 1]   (cross [1 0 0] [0 1 0])))
    (is (= [0 0 0]   (cross [1 0 0] [1 0 0]))))

(deftest test-norm
    (is (= 0 (norm origin )))
    (is (= (Math/sqrt 3) (norm [1 1 1])))
    (is (= (Math/sqrt 2) (norm [1 0 -1]))))

(deftest test-normalise
    (is (= [(/ 2.0 7.0) (/ 3.0 7.0) (/ 6.0 7.0)] (normalise [2 3 6]))))

(deftest test-det
    (is (= 1 (det [1 0 0] [0 1 0] [0 0 1])))
    (is (= 3 (det [1 1 0] [1 2 3] [4 5 6])))
    (is (= 0 (det [1 1 1] [1 2 3] [4 5 6]))))
    
(deftest test-invdet
    (is (= 1 (invdet [1 0 0] [0 1 0] [0 0 1])))
    (is (= (/ 1 3) (invdet [1 1 0] [1 2 3] [4 5 6])))
    (is (nil? (invdet [1 1 1] [1 2 3] [4 5 6]))))
{% endhighlight %}

As you can see, these are fairly basic tests but they do exercise all of the important functions in `vec.clj`.

The tests can be run from the interactive session of Clojure like so:

	Clojure
	user=> (use 'test.vec 'clojure.contrib.test-is)
	user=> (run-tests 'test.vec)                   

	Testing test.vec

	Ran 11 tests containing 28 assertions.
	0 failures, 0 errors.
	
No failures. Excellent!

To avoid having to run these tests manually, I've set up a master test file in `test/test.clj` that looks like this:

{% highlight clojure %}
(ns test 
	(:use test.vec)
	(:use clojure.contrib.test-is))

(run-tests 'test.vec)
{% endhighlight %}

This will be make it easier to add new test suites as I write port more of Minilight and can be run as a script from the Terminal like so:

	$ clj test/test.clj 
	
	Testing test.vec

	Ran 11 tests containing 28 assertions.
	0 failures, 0 errors.

[stuart sierra]: http://stuartsierra.com/
[clojurecontrib]: http://code.google.com/p/clojure-contrib/

In Closing
----------
Well, that's covered the vector functions and their tests. In the next part I'll port the Triangle class which defines the geometry and properties of a triangle.

I'd like to emphasise that I'm very new to Clojure so if you see that I'm doing something unidiomatic or just plain stupid in the above please let me know in the comments.