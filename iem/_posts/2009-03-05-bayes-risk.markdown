---
layout: iem-post

title: "Probability Estimation: Bayes Risk"

excerpt: An overview of some properties of conditional, or point-wise, Bayes risks for proper losses.

location: Canberra, Australia

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

The quickest way to establish this is via a well-known result regarding concave 
functions is that the point-wise minimum of a set of concave functions is 
concave.[^1] Then, for note that for any fixed $p\in[0,1]$ the function 
$L(\eta,p)$ is linear in $\eta$ since the terms $\ell(1,p)$ and $\ell(0,p)$ are 
constant. Since linear functions are concave and, by definition, $L^*$
is their point-wise minimum we see that $L^*$ must also be concave.

Concave functions have many useful properties that have implications for the
study of point-wise risks. Firstly, they are necessarily continuous, and 
secondly, if they are twice differentiable, their second derivatives are
non-positive. That is, for all $\eta$,
\[
	(L^*)''(\eta) \leq 0
\]
which also implies that their first derivatives are monotonically 
decreasing.[^2]

As we will see in the next post, the converse of this holds too. That is, each 
concave function on $[0,1]$ can be interpreted as the point-wise Bayes risk for 
some proper loss.

[concave]: http://en.wikipedia.org/wiki/Concave_function
[p1]: /iem/proper-losses.html
[convex optimization]: http://www.stanford.edu/~boyd/cvxbook/
[hugo]: http://www.maths.qmul.ac.uk/~ht/archive/convex1.pdf

[^1]: See, for example, §3.2.3 of Boyd & Vandenberghe's freely available 
book [Convex Optimization][].
[^2]: You can easily check this is the case for the log- and square-losses.