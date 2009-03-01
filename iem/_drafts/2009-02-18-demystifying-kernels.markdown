---
title: 'Demystifying Kernels: Positive Definiteness'

excerpt: Kernel methods are an important set of techniques in modern machine learning but some of the mathematics make them intimidating. In Part 1, I try to explain positive definiteness.

location: Canberra, Australia
layout: post

---

About ten years ago, research in machine learning took an interesting turn with
the introduction of [kernel methods][kms] for classification and 
estimation---the most famous of these being the [support vector machine][svm].
Their rapid adoption was due to their impressive empirical results, their wide
applicability and strong theoretical guarantees.

Much of the theory of kernels relies on a mixture of concepts from linear 
algebra, functional analysis and statistics. 
The aim of this series of posts is to explain some of the more important 
ones---positive definiteness, 
reproducing kernel Hilbert spaces, and the 
representer theorem. 
As these were the ones I had difficulty understanding I 
hope my attempt to provide an intuition for them will make it easier for others
to approach this material, including more technical overviews such as the 
recent _[Kernel Methods in Machine Learning][arXiv]_.

[kms]: http://en.wikipedia.org/wiki/Kernel_methods
[svm]: http://en.wikipedia.org/wiki/Support_vector_machine

Kernels and Similarity
----------------------
One way of thinking about kernels that I find useful is that they are a
measure of similarity between objects. 

We will use $\mathcal{X}$ to denote the
complete set of instances we are interested in. These could be documents, 
images, graphs, whatever. 
To measure the similarity between two instances $x_1, x_2 \in \mathcal{X}$
we will use a function $k(x_1, x_2)$. Large values of 

Implicit Representation
-----------------------
Kernel methods were a departure from the prevailing ones at the time (decision 
trees, naïve Bayes, _etc_.) as kernel methods rely only on a notion
of _similarity between instances_ in a training set rather than any particular 
representation of individual instances.

For example, a naïve Bayes spam filter might represent each email as a
"bag of words" and classify new email as spam if it contains words that 
appeared frequently in email "bags" that were labelled as spam in the training 
set.
In contrast, a support vector machine (SVM) algorithm only needs a kernel 
(_e.g._, a [string kernel][stringkernel]) that determines whether two emails are 
similar. 
The SVM algorithm then identifies a small number of crucial spam and ham emails 
(the support vectors) which new emails are compared against using the kernel to 
make a classification.

[stringkernel]: http://jmlr.csail.mit.edu/papers/v2/lodhi02a.html

The key point here is that 

Kernels can be described for any object (graphs, images, text, sound) even when
a vector representation of individual instances may be cumbersome.

The success of kernel methods is due

So when can a binary function be thought of as computing an inner product in 
some high-dimensional space? That, when does there exist a mapping 
$\Phi : \mathcal{X} \to \mathcal{H}$

Positive Definiteness
---------------------

(Main theorem is that kernel can be viewed as a dot product in some other space
if and only if the kernel is _positive definite_).

> **Positive Definite Matrix**: A real-valued $n\times n$ matrix 
> $K = (K_{ij})$ is 
> _positive definite_ if it is symmetric and for all $c_i \in \mathbb{R}$
> satisfies
> \[ \displaystyle
>     \sum_{i,j=1}^n c_i c_j K_{ij} \geq 0
> \]

The notion of positive definiteness is extended to functions in a natural way.
Specifically, a positive definite function is one that yields a positive 
definite matrix whenever it is applied to some finite set of points (_e.g._, a 
training sample).

> **Positive Definite Function**: A function 
> $k : \mathcal{X} \times \mathcal{X} \to \mathbb{R}$ is _positive definite_
> if for all finite sets $\{ x_i \} \subset \mathcal{X}$ the kernel matrix
> $K = (k(x_i, x_j))$
> is positive definite.

(Positive definiteness implies the kernel matrix $K$ can be decomposed as
$K = LL^{T}$ using a [Cholesky decomposition][cholesky]. This means that 
\[
	\displaystyle
	x^{T}Ky = (Lx)^{T}(Ly) = \langle \Phi(x), \Phi(y)\rangle
\]
for $\Phi(x) = Lx$)

(In some sense we can view $L$ as a "square-root" of $K$ which sits well with 
the analogy with positive numbers)

[cholesky]: http://en.wikipedia.org/wiki/Cholesky_decomposition

References
----------
1. Hofmann, T., Schölkopf, B. and Smola, A.J., 
_[Kernel Methods in Machine Learning](http://projecteuclid.org/euclid.aos/1211819561)_, 
Annals of Statistics, Vol. 36 (3), 2008. \[[arXiv pre-print][arXiv]\]

[arXiv]: http://arxiv.org/abs/math/0701907