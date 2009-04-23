---
title: Some Overviews of Statistical Learning Theory

excerpt: Statistical learning theory is a broad an sometimes very technical topic. Fortunately, there are a number of good surveys of the area that are pitched at various levels. Here I try to give an overview of the ones I have read.

layout: iem-post

---

Statistical learning theory is the branch of machine learning that tries to answer broad questions such as, what guarantees do we have that method X will learn?

Beginner
--------
The following papers are an excellent place to start if you are unfamiliar with the basic ideas of learning theory: risk, consistency, capacity, _etc_.

* [Statistical Learning Theory: Models, Concepts, and Results][vonLuxburg2008] (2008)
: von Luxburg, U. and Schölkopf, B. _arXiv:0810.4752v1_
  
  This gives a very accessible overview of the types of results that one usually encounters in learning theory, and presents them in such a way that the connections between the different approaches and results are mode clear. It covers a variety of estimation bounds including: classical VC, large margin, Radamacher complexity, and PAC-Bayes.

  There is also material on the No Free Lunch Theorems...

Intermediate
------------

* [Theory of Classification: A Survey of Some Recent Advances][Boucheron2005] (2005)
: Boucheron, S. and Bousquet, O. and Lugosi, G. _ESAIM Probability and Statistics_ Vol. 9

* [Tutorial on practical prediction theory for classification][Langford2005] (2006)
: Langford, J. _Journal of Machine Learning Research_ Vol. 6
  
  Starts with bounds on binomial distributions and builds up theory from there.

Hard
----

* [A Few Notes on Statistical Learning Theory][Mendelson2003] (2003)
: Mendelson, S., In _Advanced Lectures on Machine Learning_, Springer
  
  A more technical treatment...

[vonLuxburg2008]: http://arxiv.org/pdf/0810.4752
[Boucheron2005]: http://www.econ.upf.edu/~lugosi/esaimsurvey.pdf
[Langford2005]: http://jmlr.csail.mit.edu/papers/volume6/langford05a/langford05a.pdf
[Mendelson2003]: http://wwwmaths.anu.edu.au/~mendelso/papers/summer02.pdf
