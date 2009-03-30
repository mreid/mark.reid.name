---
title: "Probability Estimation: An Introduction"

excerpt: Probability estimation is an important class of problem in machine learning. In this, the first of a series of posts, I discuss a natural class of losses for these problems.

location: Canberra, Australia

layout: iem-post

---

In my recent research I have been looking at relationships between various types
of learning problems. One surprisingly rich class of problems is that of 
probability estimation. In this series of posts I will 
highlight some of the interesting theory I've uncovered about them in the
machine learning, statistics and economics literature.

Binary Classification
---------------------
The quintessential type of learning problem in machine learning is binary 
classification. Given a training sample of instances, each labelled "positive" 
or "negative", the aim is to learn to predict the correct label from previously 
unseen instances. A well known example of a binary classification problem is 
predicting whether an email is spam or not spam.

A binary classification problem can be stated as an optimisation: find 
function that minimises the average number of misclassifications on new 
instances drawn from the distribution that generated the training sample.
Put another way, if we have to pay a penalty of $1 each time we predict a 
positive instance as negative or _vice versa_ then we want to find a predictor 
that minimises our expected loss.[^1]

[^1]: Of course, in the case of spam the penalty is not as symmetric as 
described here. Incorrectly predicting spam as "not spam" is mildly annoying
whereas predicting that an important email that your career depends upon as
"spam" and sending it to the Trash folder is potentially disastrous!

Formally, we will say an instance $x$ is positive if it has associated label
$y = 1$ and negative if its label $y = 0$.
We then define the _0-1 misclassification loss_ for a binary prediction $p$
when the label is $y$ to be
\[	\displaystyle
	\ell_{01}(y,p) = 
	\begin{cases}
		1, &	y \ne p \\
		0, &	\text{otherwise}.
	\end{cases}
\]
Now suppose that an instance $x$ has a positive label with probability 
$\eta$ and we have made a prediction $p$. For that $x$ the _point-wise risk_
is
\[
	\displaystyle
	L_{01}(\eta,p) 
	= \eta\,\ell_{01}(1,p) + (1-\eta)\,\ell_{01}(0,p).
\]
The first term is the average loss of a prediction $p$ in the case of a positive 
example, occurring with probability $\eta$, and the second term is the 
average loss for a negative example, occurring with probability $1-\eta$. 

Returning to the spam example, suppose that with probability 0.95 a randomly 
chosen recipient says a particular email is spam. A prediction of "spam" for
that email will incur an average loss of $0.95\times 0 + 0.05\times 1 = 0.05$
whereas a prediction of "not spam" incurs a loss of 0.95.

Probability Estimation
----------------------
Now suppose that instead of merely predicting the correct label we wanted to 
know the _probability_ that an email was considered spam. In this case we would 
have a different but related type of learning problem: binary class probability 
estimation.

As predictions here are probabilities instead of concrete predictions, there 
is no sensible notion of a misclassification.
How can a prediction that an email is spam with probability 0.9 be wrong? If it
really isn't spam it may just be one of the 10% of cases that are consistent 
with the probability estimate. 

What we really want is a penalty with an _expected value_ that is minimised 
if our probability estimates are consistent with the _true probability_ of 
a positive label for a given instance. This fairly natural requirement on
the loss for a probability estimation problem is known as 
_Fisher consistency_.

If $\ell(y,p)$ is a loss for probability estimation then the above requirement
can be framed in terms of its associated point-wise risk:
$L(\eta,p) = \eta\,\ell(1,p) + (1-\eta)\,\ell(0,p)$. 
Stated formally, Fisher consistency says that no matter what true probability
$\eta$ we have
\[  \displaystyle
	\min_{p\in[0,1]} L(\eta,p) = L(\eta,\eta).
\]
That is, predicting $p = \eta$ always achieves the smallest possible point-wise 
risk.

We will call losses that have this Fisher consistency property _proper losses_
in line with the terminology of _proper scoring rules_ used when 
probability elicitation is studied in economics.[^2] We will see several 
interesting connections between these two concepts in future posts.

[^2]: Scoring rules are usually framed in terms of rewards rather than penalties
so loss and scoring rules are additive inverse and minimisation here becomes 
maximisation there.

Examples
--------
One common loss functions used for probability estimation is
_square loss_
\[
	\displaystyle
	\ell_{\text{sq}}(y,p) = y(1-p)^2 + (1-y) p^2.
\]
The easiest way to convince yourself this is Fisher consistent is to
examine when the derivatives of its point-wise risk with respect to $p$ 
vanishes. In the case of square loss we see that
\[
	\frac{\partial}{\partial p} L_{\text{sq}}(\eta,p)
	= -2\eta(1-p) + 2(1-\eta)p = 2(p-\eta)
\]
which is 0 only when $p=\eta$ and so $\ell_{\text{sq}}$ is proper.

While Fisher consistency seems like a fairly innocuous and natural constraint
for probability estimation it has some impressive implications that I will
explore in some future posts.