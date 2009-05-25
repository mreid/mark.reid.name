---
title: Generalised Pinsker Inequalities and Surrogate Regret Bounds

excerpt: Robert Williamson and I have had two papers accepted at ICML and COLT 2009. They are both about bounds -- one for surrogate losses the other for f-divergences.

location: Canberra, Australia

layout: iem-post

---

Just a quick note to say that [Bob Williamson][bob] and I have improved a few of the results we had previously written up in our [technical report][tr] and even managed to get some of them accepted to [ICML][] and [COLT][] this year.

[bob]: http://axiom.anu.edu.au/~williams/
[tr]: /iem/information-divergence-and-risk.html
[icml]: http://www.cs.mcgill.ca/~icml2009/
[colt]: http://www.cs.mcgill.ca/~colt2009

The ICML paper is [Surrogate Regret Bounds for Proper Losses][icmlpaper]. In it we extend earlier results on surrogate bounds for 0-1 misclassification loss to cost-weighted misclassification losses and proper losses. We also investigate conditions for convexity of composite proper losses.

As the abstract puts it:

> We present tight surrogate regret bounds for the class of proper 
> (i.e., Fisher consistent) losses. The bounds generalise the margin-based 
> bounds due to Bartlett et al. (2006). The proof uses Taylor's theorem and 
> leads to new representations for loss and regret and a simple proof of 
> the integral representation of proper losses. We also present a different
> formulation of a duality result of Bregman divergences which leads to a
> demonstration of the convexity of composite losses using canonical link 
> functions.

What I particularly like about this paper is that these results and several earlier ones regarding proper losses are arrived at using little more than a Taylor series expansion.

[icmlpaper]: http://www.cs.mcgill.ca/~icml2009/abstracts.html#400

The COLT paper, [Generalised Pinsker Inequalities][coltpaper], is (unsurprisingly) a bit more technical. As the name suggests, we were able to generalise the classical [Pinsker inequality][][^1] that provides a lower bound on the KL divergence $KL(P,Q)$ between the distributions $P$ and $Q$ in terms of their variational divergence $V(P,Q)$:
\[
	KL(P,Q) \ge \frac{1}{2} [V(P,Q)]^2 
\]

Not only were we able to tighten this bound but we provide a template for constructing similar (and tight) bounds for any [f-divergence][fdiv] in terms of variational divergence. Furthermore, we also generalise the bounds to make use of one or more non-symmetric variational divergences. 

Here's the abstract:
> We generalise the classical Pinsker inequality 
> which relates variational divergence to Kullback-Liebler 
> divergence in two ways: we consider arbitrary f -divergences 
> in place of KL divergence, and we assume knowledge of a sequence 
> of values of generalised variational divergences. 
> We then develop a best possible inequality for 
> this doubly generalised situation. Specialising 
> our result to the classical case provides a new 
> and tight explicit bound relating KL to variational divergence 
> (solving a problem posed by Vajda some 40 years ago). 
> The solution relies on exploiting a connection between 
> divergences and the Bayes risk of a learning problem 
> via an integral representation. 

[coltpaper]: /files/pubs/colt09.pdf
[pinsker inequality]: http://en.wikipedia.org/wiki/Pinsker's_inequality
[fdiv]: http://en.wikipedia.org/wiki/F-divergence

[^1]: The statement of Pinsker's inequality on the Wikipedia page uses a version of variational divergence that differs from ours by a factor of 2.

Although the proof requires some careful, technical detail, the approach is very simple and geometric. It makes use of the fact that any f-divergence can be written as a weighted integral of variational-like divergences and the fact that f-divergences are related to Bayes risk curves for proper losses. 

In a very loose sense, these papers are duals of each other: the bounds in both share a similar structure -- what can be said about a "complex" divergence given information about some "simple" divergences vs. what can be said about a "simple" loss given information about a "complex" one -- and both are driven by the integral representation of losses and divergences which provides an interpretation of "simple" and "complex". 

I'll be presenting both these papers in Montréal in June so if you are also attending ICML and COLT and are interested in these results please let me know.
