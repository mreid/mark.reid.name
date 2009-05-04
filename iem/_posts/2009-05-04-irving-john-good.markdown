---
title: Irving “Jack” Good (1916–2009)

excerpt: Noting the passing of one of the big names in Bayesian statistics with a discussion some of his work I am personally familiar with.

location: Canberra, Australia

layout: iem-post

---

The [Language Log][] recently noted the passing of the eminent statistician, probability theorist, WWII code-breaker, colleague of Alan Turing and populariser of Go, Irving John "Jack" Good who died on April the 5<sup>th</sup> at the ripe old age of 92.

[language log]: http://languagelog.ldc.upenn.edu/nll/?p=1386

As I have [mentioned earlier][rcb] on this blog, Good's 1965 monograph, "[The Estimation of Probabilities: An Essay on Modern Bayesian Methods][eop]" was especially influential for my research. In this slim volume was a beautifully written treatise on how to estimate probabilities from "effectively small samples" -- exactly the problem I was facing in my [thesis][]. When samples are scarce, evaluating models becomes difficult because many models can share exactly the same misclassification rates.

It was by chance that I read his discussion of Dirichlet priors for multinomial samples and realised that they were the perfect tool for smoothing estimations of misclassification counts in contingency tables. By learning these priors on one task and transferring them to new, similar tasks I was able to break ties between models in a principled way by using the performance of similar models on earlier tasks.

[rcb]: /iem/research-changing-books.html
[eop]: http://mitpress.mit.edu/catalog/item/default.asp?ttype=2&tid=9821
[thesis]: http://arrow.unsw.edu.au/vital/access/manager/Repository/unsworks:1253

The other time I encountered Good's work was when reading about population estimation. [Good-Turing estimation][gte] is a clever statistical technique developed by Good and Turing when they worked together as code-breakers at Bletchley Park. When randomly sampling items from some unknown number of classes, the Good-Turing estimator takes into account the probability that the next randomly selected item comes from a previously _unseen_ class. This is very useful in areas such as linguistics where vocabularies are only incompletely known through some relatively small corpus of text.

[gte]: http://en.wikipedia.org/wiki/Good-Turing

Essentially, their technique estimates then smoothes the _frequencies of the frequencies_ of the observed classes -- the number of times a class with one item is observed, the number of times a class with two items is observed, and so on. By fitting a linear model to a log-log plot of these smoothed frequencies of frequencies estimates of low frequency classes can be revised upwards, possibly from 0, and an estimate of number of unseen class can be made.

In general, Good's work could be described as that of a practical subjective Bayesian and I think he summed up this position very elegantly in a footnote in his monograph:

> In our theories, we rightly search for unification, but real life is 
> both complicated and short, and we make no mockery of honest ad hockery.

