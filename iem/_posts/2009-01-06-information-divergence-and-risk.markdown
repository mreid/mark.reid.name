---
layout: iem-post

title: Information, Divergence and Risk for Binary Experiments
excerpt: A summary of a recent paper Bob and I posted to arXiv.
location: Canberra, Australia

wordpress_url: http://conflate.net/inductio/?p=175
wordpress_id: 175
---
[Bob Williamson][bob] and I have finished a [report][] outlining what we have been looking at for the last year or so and uploaded it to the arXiv. Weighing in at 89 pages, it covers a lot of ground in an attempt to unify a number of different classes of measures for problems that can be expressed as binary experiments. That is, where instances are drawn from two distributions. This include binary classification, class probability estimation, and hypothesis testing. 

We show that many of the usual measures of difficultly for these problems — divergence, information and Bayes risk — are very closely related. We also look at ways in which members of each class of measure can be expressed in terms of "primitive" members of those classes. In particular, Fisher-consistent losses (also known as proper scoring rules) can be written as weighted sums of cost-sensitive loss while all f-divergences can be written as weighted sums of something akin to cost-sensitive variational divergence. These "Choquet representations" make it easy to derive Pinsker-like bounds for arbitrary f-divergences (not just KL divergence) as well as results similar to those of Bartlett et al in their "[Convexity, classification and Risk Bounds][bartlett]".

It should be made clear that many of these results are not new. However, what I like about our approach is that almost all of the results in the paper stem from a two observations about convex functions: they are invariant under the Legendre-Fenchel bidual, and they have a second-order integral Taylor expansion with non-negative weights.

If any of this sounds interesting, you should grab the full paper from the [arXiv][report]. Here's the abstract:

> We unify f-divergences, Bregman divergences, surrogate loss bounds (regret bounds), 
> proper scoring rules, matching losses, cost curves, ROC-curves and information. We 
> do this by systematically studying integral and variational representations of these 
> objects and in so doing identify their primitives which all are related to cost-sensitive 
> binary classification. As well as clarifying relationships between generative and 
> discriminative views of learning, the new machinery leads to tight and more general 
> surrogate loss bounds and generalised Pinsker inequalities relating f-divergences to 
> variational divergence. The new viewpoint illuminates existing algorithms: it provides a 
> new derivation of Support Vector Machines in terms of divergences and relates 
> Maximum Mean Discrepancy to Fisher Linear Discriminants. It also suggests new 
> techniques for estimating f-divergences.

Now that we have a good understanding of binary experiments the aim is to build on these results and extend this type of work to other forms of machine learning problems. High on the list are multi-category classification, ranking and regression problems.

Questions, criticism, suggestions and pointers to related work we may have missed are all welcome. 

[bartlett]: http://www.citeulike.org/user/mdreid/article/510440
[report]: http://arxiv.org/abs/0901.0356
[bob]: http://axiom.anu.edu.au/~williams/