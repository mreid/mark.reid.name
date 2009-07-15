---

title: Online Learning in Clojure

excerpt: In an attempt to better familiarise myself with online learning and Clojure I implemented the former in the latter.

location: Canberra, Australia
layout: sap-post

---
[Online Learning][] is a relatively old branch of machine learning that has recently regained favour for two reasons. Firstly, online learning algorithms such as [Stochastic Gradient Descent][sgd] work extremely well on very large data sets which have become increasingly prevalent (and increasingly large!). Secondly, there has been a lot of [important theoretical steps][plg] made recently in understand the convergence behaviour of these algorithms and their [relationship][] to traditional Empirical Risk Minimisation (ERM) algorithms such as Support Vector Machines (SVMs).

[online learning]: http://en.wikipedia.org/wiki/Online_machine_learning
[sgd]: http://leon.bottou.org/research/stochastic
[plg]: http://homes.dsi.unimi.it/~cesabian/predbook/
[relationship]: http://arxiv.org/abs/0903.5328

In order to understand these algorithms better, I implemented a recent one (Pegasos, described below) in [Clojure][]. This had the added advantage of seeing how well Clojure's performance held up when doing some serious number-crunching.

Online Learning
---------------
One very appealing property of online learning algorithms is that they are extremely simple. Here's what a general supervised online learning algorithm looks like. Given a loss function $L$ and a stream of examples $S$ of the form $(x,y)$, do the following:

	Initialise a starting model w
	While there are more examples in S
	    Get the next feature vector x
	    Predict the label y' for x using the model w
	    Get the true label y for x and incur a penaly L(y,y')
	    Update the model w if y ≠ y'

Models are usually represented as vectors of weights for the features used to represent the examples. For binary classification problems predictions involve looking at the sign of the innner product $\langle w,x \rangle$ and the update step in line 2.3 modifies the current model by moving $w$ in the direction that most reduces the loss of the incorrect prediction: that is, in the direction given by the negative [gradient][] of the loss.

[gradient]: http://en.wikipedia.org/wiki/Gradient

Pegasos
-------
One recent online algorithm (and the one I've chosen to implement) is _[Pegasos: Primal Estimated sub-GrAdient SOlver for SVM][pegasosabs]_ ([PDF][pegasospdf]) introduced by [Shai Shalev-Shwartz][shai], [Yoram Singer][yoram] and [Nathan Srebro][nati] at [ICML 2007][icml2007] [^1]. As this is my programming blog (not my [research blog][iem]) I'll just give enough of the detail of Pegasos so you can follow the implementation.

[iem]: /iem/

Pegasos solves the same optimisation problem as [support vector machines][svm]. That is, it minimises the empirical hinge loss with $\ell_2$ regularisation:
\[ \displaystyle
	L(w,S) 
	= \frac{\lambda}{2}\|w\|^2 + \frac{1}{m} \sum_{(x,y)\in S} h(w; (x,y))
\] 
where $S$ is a set of training examples, $\|\cdot \|$ the $\ell_2$ norm, $\lambda$ the regularisation constant and 
$h(w;(x,y)) = \max\{0, 1-y\langle w, x \rangle\}$ 
is the hinge loss.

[svm]: http://en.wikipedia.org/wiki/Support_vector_machine

The neat observation that allows optimisation problems like this to be cast as online learning problems is that the above loss can be computed using example-by-example updates rather than as a large sum. With a little care about how these updates are made fast convergence guarantees can be established.

In the case of Pegasos, if $w_t$ is the model after having seen $t$ examples and $(x,y)$ is an incorrectly predicted example, the (unnormalised) updated model is:
\[ \displaystyle
	w_{t+1} = (1-t^{-1})w_t + \frac{1}{\lambda t} yx.
\]
If the new model is outside a ball of radius $1/\sqrt{\lambda}$ it is projected back onto this ball.

Implementing it in Clojure
--------------------------
Once I understood what it was doing, Pegasos struck me as a very simple algorithm so I was itching to implement it. As mentioned earler, I was also curious as to [Clojure][]'s performance on number-crunching tasks like this, especially when the [canonical data set][rcv1] for online learning has over 700,000 examples and over 45,000 features.

[clojure]: http://clojure.org
[rcv1]: http://jmlr.csail.mit.edu/papers/volume5/lewis04a/lyrl2004_rcv1v2_README.htm

Represented as 45k entry feature vectors, the examples and models would quickly become unwieldy so the first order of business was to implement some sparse vector operations. Here I chose to represent vectors as hash maps where non-zero elements of a vector are stored with their index as a key and the value of the entry as value.

{% highlight clojure %}
(defn add
	"Returns the sparse sum of two sparse vectors x y"
	[x y] (merge-with + x y))

(defn inner
	"Computes the inner product of the sparse vectors (hashes) x and y"
	[x y] (reduce + (map #(* (get x % 0) (get y % 0)) (keys y))))

(defn norm
	"Returns the l_2 norm of the (sparse) vector v"
	[v] (Math/sqrt (inner v v)))

(defn scale
	"Returns the scalar product of the sparse vector v by the scalar a"
	[a v] (zipmap (keys v) (map * (vals v) (repeat a))))

(defn project
	"Returns the projection of a parameter vector w onto the ball of radius r"
	[w r] (scale (min (/ r (norm w)) 1) w))
{% endhighlight %}

The only slightly tricky thing here is the use of `zipmap` to scale a sparse vector by mapping all the keys in the original vector to their values times a scalar multiple `a`.

The other bit of framework code I required was to parse the training data. The format is a simple version of that used by [SVMlight][]. Each line of the text file containing the training data is of the form:

	y k_1:v_1 k_2:v_2 ... k_n:v_n

where `y` is the label (either `1` or `-1`), each `k_i` is an integer key representing a feature index, and each `v_i` is a floating point value.

[svmlight]: http://svmlight.joachims.org/

The Clojure code to parse this format is a pretty straight-forward application of regular expressions:

{% highlight clojure %}
(defn parse-feature 
	[string] 
	(let [ [_ key val] (re-matches #"(\d+):(.*)" string)]
		[(Integer/parseInt key) (Float/parseFloat val)]))

(defn parse-features
	[string]
	(into {} (map parse-feature (re-seq #"[^\s]+" string))))

(defn parse
	"Returns a map {:y label, :x sparse-feature-vector} parsed from given line"
	[line]
	(let [ [_ label features] (re-matches #"^(-?\d+)(.*)$" line) ]
		{:y (Float/parseFloat label), :x (parse-features features)}))
{% endhighlight %}

The main parsing function `parse` takes a whole line in this format as input and returns a hash map with key `:y` giving the label of the example and `:x` giving a hash map representing the feature vector.

Finally, the code to perform a single update step for a model given an example is built using some helper functions. The loss is computed by `hinge-loss`, the function `correct` performs a single gradient descent step, and `report` is just for diagnostics and prints some simple statistics about the model and its performance.

{% highlight clojure %}
(defn hinge-loss
	"Returns the hinge loss of the weight vector w on the given example"
	[w example] (max 0 (- 1 (* (:y example) (inner w (:x example))))))
	
(defn correct
	"Returns a corrected version of the weight vector w"
	[w example t lambda]
	(let [x   (:x example)
		  y   (:y example)
		  w1  (scale (- 1 (/ 1 t)) w)
		  eta (/ 1 (* lambda t))
		  r   (/ 1 (Math/sqrt lambda))]
		(project (add w1 (scale (* eta y) x)) r)))

(defn report
	"Prints some statistics about the given model at the specified interval"
	[model interval]
	(if (zero? (mod (:step model) interval))
		(let [t      (:step model)
		      size   (count (keys (:w model)))
		      errors (:errors model) ]
			(println "Step:" t 
				 "\t Features in w =" size 
				 "\t Errors =" errors 
				 "\t Accuracy =" (/ (float errors) t)))))

(defn update
	"Returns an updated model by taking the last model, the next training 
	 and applying the Pegasos update step"
	[model example]
	(let [lambda (:lambda model)
		  t      (:step   model)
		  w      (:w      model)
		  errors (:errors model)
		  error  (> (hinge-loss w example) 0)]
		(do 
			(report model 100)
			{ :w      (if error (correct w example t lambda) w), 
			  :lambda lambda, 
			  :step   (inc t), 
			  :errors (if error (inc errors) errors)} )))
{% endhighlight %}

As you can see, this function returns a new, updated model as a hash that contains the feature weights `:w` as well as several other useful bits of information including the culmulative number of errors (in `:errors`) and the total number of update steps (in `:steps`). The parameter $\lambda$ which controls the amount of regularisation is also passed along in the model (in `:lambda`) for convenience.

_A brief aside_: If I have one criticism of Clojure as a language it's that implementing numerical procedures is a real pain. Prefix notation (while neatly side-stepping problems of operator precedence) is just a lot harder to read than the infix notation that many non-Lisp languages use.
{:.quiet }

Now the update step is implemented, training a model online from a sequence of examples is a simple application of `reduce`. The following code repeated calls `(update model example)` where each example is taken from the sequence `examples` and the model output by the last call to `update` is used as input for the next.

{% highlight clojure %}
(defn train
	"Returns a model trained from the initial model on the given examples"
	[initial examples]
	(reduce update initial examples))
{% endhighlight %}

All that's needed now is a main method to read examples from the standard input, parse them into vectors and train a model from some starting point:

{% highlight clojure %}
(defn main
	"Trains a model from the examples and prints out its weights"
	[]
	(let [start 	{:lambda 0.0001, :step 1, :w {}, :errors 0} 
		  examples 	(map parse (-> *in* BufferedReader. line-seq)) 
		  model     (train start examples)]
		(println (map #(str (key %) ":" (val %)) (:w model)))))
{% endhighlight %}

When finished the `main` function prints the weights for the final trained model to the command line in a format similar to the input data. The training starts with an empty model and a regularisation constant of 0.0001 (as was used in the paper describing Pegasos).

The full version of the code is [available at GitHub][github].

[github]: http://github.com/mreid/injuce/

Running It
----------
To see whether the algorithms (or at least my implementation of it) performs as advertised I ran it on the aforementioned RCV1 data set. 

This is a big data set. 

The gzipped version of the full data set weighs in at 423Mb. Understandably, I'm not going to host a file that size so to get the full data set it you will have to follow the [instructions at Léon Bottou's SGD page][data] and make it yourself. However, for the purposes of this blog post I've created a 2,000 example version called `train2000.dat.gz` that is checked into the [repository][github].

[data]: http://leon.bottou.org/projects/sgd

With the training data in hand I ran my implementation of Pegasos (in the file `sgd.clj`) like so:

	$ zless train2000.dat.gz | clj sgd.clj > output.txt
	Step: 100 	 Features in w = 2145 	 Errors = 64 	 Accuracy = 0.64
	Step: 200 	 Features in w = 3333 	 Errors = 123 	 Accuracy = 0.615
	Step: 300 	 Features in w = 4051 	 Errors = 175 	 Accuracy = 0.5833333
	Step: 400 	 Features in w = 4755 	 Errors = 229 	 Accuracy = 0.5725
	Step: 500 	 Features in w = 5236 	 Errors = 276 	 Accuracy = 0.552
	Step: 600 	 Features in w = 5576 	 Errors = 318 	 Accuracy = 0.53
	Step: 700 	 Features in w = 5870 	 Errors = 356 	 Accuracy = 0.50857145
	Step: 800 	 Features in w = 6050 	 Errors = 388 	 Accuracy = 0.485
	Step: 900 	 Features in w = 6325 	 Errors = 418 	 Accuracy = 0.46444446
	Step: 1000 	 Features in w = 6578 	 Errors = 444 	 Accuracy = 0.444
	Step: 1100 	 Features in w = 6747 	 Errors = 471 	 Accuracy = 0.42818183
	Step: 1200 	 Features in w = 6934 	 Errors = 502 	 Accuracy = 0.41833332
	Step: 1300 	 Features in w = 7109 	 Errors = 526 	 Accuracy = 0.40461537
	Step: 1400 	 Features in w = 7300 	 Errors = 555 	 Accuracy = 0.39642859
	Step: 1500 	 Features in w = 7515 	 Errors = 592 	 Accuracy = 0.39466667
	Step: 1600 	 Features in w = 7655 	 Errors = 615 	 Accuracy = 0.384375
	Step: 1700 	 Features in w = 7836 	 Errors = 644 	 Accuracy = 0.37882352
	Step: 1800 	 Features in w = 8040 	 Errors = 672 	 Accuracy = 0.37333333
	Step: 1900 	 Features in w = 8239 	 Errors = 697 	 Accuracy = 0.3668421
	Step: 2000 	 Features in w = 8425 	 Errors = 718 	 Accuracy = 0.359

As you can see the algorithm slowly adds more and more features to the weight vector and, as a result, slowly improves the accuracy. 

The reported accuracy is simply the cumulative total number of errors divided by the number of steps. This is a fairly pessimistic take on how the later models are performing. In the last 100 examples the models made a combined total of only 19 mistakes so the final model accuracy is probably closer to 20% than 35%.

Performance
-----------
My biggest issue with my implementation of online learning in Clojure is that it is too slow. The 2,000 example test described above took about 40 seconds to complete.

These algorithms are meant to be ridiculously fast. Léon Bottou [reports][data] training times for his C++ stochastic gradient descent algorithm on the *full* 780k example RCV1 data set of *1.4 seconds*! 

Granted I was timing both the parsing and training of the data but on the other hand I'm using less than 0.3% of the data. Indeed, a quick test shows that just parsing the 2,000 examples takes less than 2 seconds so just training on the 2,000 examples takes 35 seconds or more.

Firing up the [JVisualVM][jvvm] to see where my code is spending most of its time reveals that a lot of time is spent getting variable values and looking up values in maps.

The performance culprit then is very likely my hastily thrown together sparse vector "library" built from hash maps. Although hash maps are fast there is still a lot of overhead in packing float and integer values in and out of Java Objects and I suspect this is where most of the time is wasted.

If I have time to write a next version, I'll make use of the sparse vector data structures in the Java [Parallel Colt][parcolt] library.

[jvvm]: http://www.fatvat.co.uk/2009/05/jvisualvm-and-clojure.html
[parcolt]: http://sites.google.com/site/piotrwendykier/software/parallelcolt

Conclusions
-----------
Despite its lack of speed, I was impressed with how easy it was to implement an online algorithm in Clojure. Minus the comments, the whole thing -- vector operations, reporting, data parsing and training -- weighs in at less than 100 lines of code.

Given Clojure's ability to call high-performance Java libraries such as [Parallel Colt][parcolt], I'm optimistic that I can keep the terseness and transparency of the code and get performance comparable to the C++ implementations. I would also like to experiment with exploiting Clojure's concurrency features to chunk and parallelise the main training algorithm. I suspect that this will be relatively straight-forward and, with a bit of tuning I should get good performance on a multi-core machine.

[^1]: There's a good discussion of Pegasos over at the [LingPipe blog][lingpipe].

[pegasosabs]: http://www.machinelearning.org/proceedings/icml2007/abstracts/587.htm
[pegasospdf]: http://www.machinelearning.org/proceedings/icml2007/papers/587.pdf
[shai]: http://ttic.uchicago.edu/~shai/
[yoram]: http://www.cs.huji.ac.il/~singer/
[nati]: http://ttic.uchicago.edu/~nati/
[icml2007]: http://oregonstate.edu/conferences/icml2007/

[lingpipe]: http://lingpipe-blog.com/2009/04/08/convergence-relative-sgd-pegasos-liblinear-svmlight-svmper/
