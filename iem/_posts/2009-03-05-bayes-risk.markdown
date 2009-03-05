---
layout: post

title: "Probability Estimation: Bayes Risk and Regret"

excerpt: An overview of some properties of conditional, or point-wise, Bayes risks for proper losses.

---

In my previous post on [probability estimation][p1], I introduced the notion of
a proper loss. This is a way of assigning penalties to probability estimates
so that the average loss is minimised by guessing the true conditional 
probability of a positive label for each example. This minimal possible risk is 
called the (conditional) _Bayes risk_ and in this post I will highlight some of 
its properties.

To recap briefly, we denote the loss of predicting the probability $p$ when the
label $y$ (1 for positive, 0 for negative) as $\ell(y, p)$. Then the conditional
risk for $\ell$ of guessing $p$ when $y$ has probability $\eta$ of being 
positive is
\[
	L(\eta,p) = (1-\eta)\,\ell(0,p) + \eta\,\ell(1,p).
\]

Point-wise Bayes Risk
---------------------
The best possible estimate under this loss in terms of minimising the risk at
when the probability of a positive label is $\eta$ is the _(point-wise) Bayes 
risk_ at $\eta$, which I will denote as
\[	\displaystyle
	L^*(\eta) = \min_{p \in [0,1]} L(\eta, p)
\]

As argued in the [previous post][p1], a sensible loss is one that is 
_Fisher consistent_, that is, one with a risk that is minimised when $p=\eta$.
Such a loss is called _proper_ and its risk and Bayes risk are closely related.
Specifically, $L^*(\eta) = L(\eta,\eta)$.

This relationship makes it trivial to compute the point-wise Bayes risk for
any proper loss. For example, square loss is defined to be 
$\ell_{\text{sq}}(y,p) = y\,(1-p)^2 + (1-y)\,p^2$
and so its point-wise Bayes risk is
\[
	L^*_{\text{sq}}(\eta) 
	= L_{\text{sq}}(\eta,\eta)
	= \eta(1-\eta)^2 + (1-\eta)\eta^2
	= \eta(1-\eta).
\]
Log loss is $\ell_{\text{log}}(y,p) = -y\log(p) - (1-y)\log(1-p)$ and so its
Bayes risk is
\[
	L^*_{\text{log}}(\eta) 
	= -\eta\log(\eta) - (1-\eta)\log(1-\eta).
\]

Bayes Risk Functions are Concave
--------------------------------
One useful property of point-wise Bayes risk functions for proper losses is that
they are necessarily [concave][]. That is, a line joining any two points on 
the graph of $L^*$ lies entirely below $L^*$.

As we will see in later posts, the point-wise Bayes risk functions are, in some 
sense, more fundamental than the proper losses they are derived from. 



Regret
------

[concave]: http://en.wikipedia.org/wiki/Concave_function
[p1]: /iem/proper-losses.html
