---
title: "Probability Estimation: Savage’s Theorem"

excerpt: A well-known theorem in economics that is little-known in machine learning shows how to derive a proper loss from any concave function representing its point-wise Bayes risk.

location: Canberra, Australia

layout: post

---

As we saw in the [previous post][pe2] in this series, the point-wise Bayes risk function for any proper loss is always concave. This result is one half of a characterisation of proper losses first described by [Leonard J. Savage][lsj] in his posthumously published 1971 paper _[Elicitation of Personal Probabilities and Expectations][elicit]_.

Recall that proper losses for probability estimation are precisely those that have "sensible" point-wise Bayes risks. That is, the point-wise risk $L(\eta,p)$ is always minimised for $p = \eta$. 

![Risk for log-loss](/images/figures/properloss.png)
: **Figure 1**: The point-wise risk for log loss as a function of _p_ and _η_. The red line shows the risk for the estimate _p_=0.14. The green curve shows the concave point-wise Bayes risk.

{:.figure :}



[pe2]: http://mark.reid.dev/iem/bayes-risk.html
[lsj]: http://en.wikipedia.org/wiki/Leonard_Jimmie_Savage
[elicit]: http://www.jstor.org/stable/2284229

