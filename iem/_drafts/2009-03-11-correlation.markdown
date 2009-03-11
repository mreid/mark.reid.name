---
title: Correlation, Causation and Counterfactuals

excerpt: A recent xkcd comic reveals why

location: Canberra, Australia

layout: post

---

Looking for correlations between events is an important part of science as it can be a useful indicator that one of the events caused the other. 

![xkcd on correlation and causation](/images/xkcd-correlation.png)
:	**Figure 1**: An [xkcd comic][] on correlation and causation.

{:.figure :}

Edward Tufte:
> Correlation is not causation but it sure is a hint.

David Hume is largely attributed as first studying the problem of causation. In his _[Enquiry Concerning Human Understanding][echu]_:
> We may define a cause to be an object followed by another, and 
> where all the objects, similar to the first, are followed by 
> objects similar to the second.

There is a common fallacy _cum hoc ergo propter hoc_[^1] which Mark Chu-Carroll over at _Good Math, Bad Math_ has [discussed at length][gmbm]. He argues that after noticing a correlation one should look for a demonstrable mechanism for the causation.

A converse fallacy can be found when incorrectly interpreting [p-values][].

[p-values]: /iem/the-earth-is-round.html

Conversely, there may be a mechanism for causation but no detectable (linear) correlation. [Anscombe's quartet][anscombe] 

[anscombe]: http://en.wikipedia.org/wiki/Anscombe%27s_quartet

Causation is tied up with counter-factuals

Larry Wasserman's [comment][wasserman] on Phil Dawid's _[Causal Inference without Counterfactuals][ciwc]_[^2] makes the statement mathematically precise.

Randall Munroe's xkcd comic eventually reminded of another humorous take on the topic of causation. 

Hofstadter in his _Gödel, Escher, Bach: An Eternal Golden Braid_ has a dialogue called _Contrafactus_ in which Achilles, the Crab and several other characters are watching a football on a Subjunc-TV --- a television capable of subjunctive instant replays. They rewatch a football play with increasingly implausible counterfactuals and the Sloth asks what it might have looked like if addition were not commutative.

> I find the whole idea of Subjunc-TV's one giant bore. But perhaps I 
> could change my mind, if I had some evidence that your machine here 
> could handle an INTERESTING counterfactual. For example, how would 
> that last play have looked if addition were not commutative? 

[Judea Pearl][]'s [slides][] on _Reasoning with Cause and Effect_ and has a [blog][] dedicated to the topic.

[Probabilistic Causation][sep]

[^1]: Of course, _Quidquid latine dictum sit, altum viditur_ (anything said in Latin is profound).

[^2]: A. P. Dawid, _Causal Inference Without Counterfactuals_, Journal of the American Statistical Association, June 2000, Vol. 95, No. 450. [JSTOR][ciwc]

[ciwc]: http://www.jstor.org/pss/2669377
[wasserman]: http://www.jstor.org/stable/2669384
[judea pearl]: http://bayes.cs.ucla.edu/jp_home.html
[blog]: http://www.mii.ucla.edu/causality/
[slides]: http://singapore.cs.ucla.edu/IJCAI99/
[sep]: http://plato.stanford.edu/entries/causation-probabilistic/
[book]: http://bayes.cs.ucla.edu/BOOK-09/causality2-excerpts.htm
[gmbm]: http://scienceblogs.com/goodmath/2007/01/basics_correlation_1.php
[xkcd comic]: http://xkcd.com/552/
[echu]: http://www.gutenberg.org/dirs/etext06/8echu10h.htm