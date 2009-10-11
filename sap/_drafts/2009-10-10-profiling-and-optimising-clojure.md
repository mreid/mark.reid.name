---

title: Optimising Clojure 

excerpt: Wherein I discover the fruits of profiling and bespoke data structures for speeding up vector operations in stochastic gradient descent.

location: Canberra, Australia
layout: sap-post

---
My [earlier attempt][previous] at implementing [Stochastic Gradient Descent][sgd] (SGD) convinced me that [Clojure][] was an expressive, terse and flexible language. However, I was less than impressed with the performance of my implementation relative to a [reference implementation][] in C++.

After a brief, dissatisfying detour through an implementation based on the Parallel Colt library and its sparse vector classes I ended up with a purely functional solution that I'm quite happy with. Importantly, this new implementation 1.5 times longer to run than the reference C++ implementation. To put this in perspective, my original (and fairly naïve) implementation took 45 times longer to run than the C++ version which means the new optimisations make the new version **30 times** faster than the old one.

Although there were a few tweaks here and there which also helped, the bulk of this dramatic improvement can be put down to one thing: _using code profiling to identify bottlenecks_.

Thankfully, someone has already done the hard work of [micro-benchmarking][tips] various implementation decisions...

[previous]: /sap/online-learning-in-clojure.html
[clojure]: http://clojure.org/
[sgd]: http://leon.bottou.org/research/stochastic
[reference implementation]: http://leon.bottou.org/projects/sgd

[tips]: http://gnuvince.wordpress.com/2009/05/11/clojure-performance-tips/

Switching Styles
----------------
My first idea for improving performance was to take advantage of Clojure's interoperability with Java and use a third party library that implemented efficient sparse vectors.

After a bit of looking around I settled on the Parallel Colt sparse vector library (see the [inplace branch][] of my repository) but, since these Java classes are not immutable I had to substantially change the style of the code. Instead of pure functions handling the vector updates I resorted to modifying `SparseFloatMatrix1D` instances in-place.

While the result did run quite a bit faster, it still wasn't satisfyingly quick compared to Bottou's C++ version of SGD. The in-place version of my code took around 30 minutes to train from the 780k examples in the RCV1 data set whereas the C++ version finished in just under 3 minutes.

Rich Hickey's recent talk on [Persistent Data Structures and Managed References][rich-talk] makes a strong case for using immutable values whenever you need to think about state -- especially when concurrency is involved.


Profiling
---------
Using visualjvm, most of the time is now spent in the Parallel Colt library computing inner products. 

	Step 1000
	{:mean 0.106, :count 1000, :total 106.0}
	   Name      mean       min       max     count       sum
	    add    136642     36000   3047000       557  76110000
	 create    617012     18000  28319000      2000  1234024000
	  inner    112597      8000  10918000      2005  225757000
	   norm   4778200   2552000  10951000         5  23891000
	  parse    682077     32000  36173000      2000  1364154000
	project   7469600   3572000  11448000         5  37348000
	  scale   2023675     19000  156687000      1117  2260446000
	"Elapsed time: 4176.285 msecs"

Speedy Vectors
--------------
As I noted in my [last post][previous]:

> The performance culprit then is very likely my hastily thrown together sparse
> vector “library” built from hash maps. 

(Noticed scaling trick in Bottou's SVM SGD code and incorporated it into my vector library)

There were two key "tricks" that

	Step 1000
	{:mean 0.106, :count 1000, :total 106.0}
	   Name      mean       min       max     count       sum
	    add    338213     22000   7353000       557  188385000
	 create    902133     30000  144625000      2000  1804266000
	  inner     73418      8000   8840000      2000  146837000
	   norm     72600     38000    204000         5    363000
	  parse    952897     44000  144679000      2000  1905795000
	project    112800     43000    369000         5    564000
	  scale      1551      1000     91000      1117   1733000
	"Elapsed time: 2685.153 msecs"

(Note: above is on my home machine -- a 2.66GHz iMac -- whereas the other profile data is on my work iMac -- a 2.85GHz(?) iMac)

Laziness and Memory Use
-----------------------


Easy Parallelism
----------------

(Also, `memoize`)

Conclusions
-----------
The morals of this story are:
* Good profiling tools are very valuable.
* Careful design of data structures can give huge speed gains.
* Do not hang onto large lazy sequences as they are realised.
* Functional code makes for easy concurrency. 

[rich-talk]: http://www.infoq.com/presentations/Value-Identity-State-Rich-Hickey

[inplace branch]: http://github.com/mreid/injuce/blob/inplace/sgd.clj