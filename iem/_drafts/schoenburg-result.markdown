---
title: Kernels, Metrics and Hilbert Spaces 

excerpt: When can you isometrically embed a metric space in a Hilbert space? A nice result from the 1930s gives a complete characterisation.

location: Canberra, Australia
layout: post

---

I have recently been interested in learning from 

Paper[^1] by Hein, Bousquet and Schölkopf dug up a 1930's result by 
Schoenberg[^3] that completely characterises when one can map points from a 
metric space into a Hilbert space and preserve the distances between all of 
them.

[PDF](http://www.kyb.mpg.de/publications/pdfs/pdf2839.pdf)

Ule calls this the "Schoenberg condition"[^2]

The result states that you can do this when -d^2 is conditionally positive 
semi-definite.

> A metric $d$ defined on a space $\mathcal{X}$ is called a _Hilbertian metric_
> if $(\mathcal{X}, d)$ can be isometrically embedded into a Hilbert space,
> or equivalently if $-d^2$ is conditionally positive definite.

Conditionally Positive Definiteness
-----------------------------------
Even though the term "conditionally positive definite" sounds slightly 
oxymoronic it does have a precise mathematical meaning.

What is "conditionally positive definite"?

Very roughly, it is a generalisation of what "positive" means for numbers.
Consider the expression $v = a.x^2$. This 

[^1]: Hein, M., Bousquet, O. and Schölkopf, B., _[Maximal Margin Classification for Metric Spaces](http://www.kyb.mpg.de/publication.html?publ=2839)_. Journal of Computer and System Sciences. Vol. 71 (3), pp 333-359 (2005).

[^2]: von Luxburg, U., _[Statistical Learning with Similarity and Dissimilarity Functions](http://www.kyb.mpg.de/publications/pdfs/pdf2836.pdf)_. Ph.D. Thesis,
Technical University of Berlin, 2004.

[^3]: Schoenberg, I.J., _[Metric Spaces and Positive Definite Functions](http://www.jstor.org/stable/1989894)_, Transactions of the AMS, Vol 44 (3), 1938.