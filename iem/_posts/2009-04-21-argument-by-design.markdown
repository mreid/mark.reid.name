---
title: Priors and the Argument By Design

excerpt: Ken Binmore gives a short Bayesian explanation of why the usual Argument By Design for the existence of God only reinforces existing beliefs.

location: Canberra, Australia

layout: iem-post

---
Although I'm not completely sold on the book as a whole, Ken Binmore's "[Rational Decisions][]" is a great collection of very sharp, terse insights into many [paradoxes][] and counter-intuitive results regarding probability and decision theory. 

[rational decisions]: http://www.librarything.com/work/book/41239432
[paradoxes]: /iem/the-horatio-principle.html

One such digression is his five sentence analysis of the "Argument By Design" that is central to the Intelligent Design movement. With minor modification to his notation, it goes like this:

> Let _F_ be the event that something appears to have been organized.
> Let _G_ be the event that there is an organizer. Everybody agrees that 
> $\mathbb{P}(F|G) > \mathbb{P}(F|\neg G)$, but the argument by design needs to
> deduce that $\mathbb{P}(G|F) > \mathbb{P}(\neg G|F)$ if God's existence is to
> be more likely than not. Applying Bayes' rule, we find that
\[
	\displaystyle
	\mathbb{P}(G|F) 
	= \frac{\mathbb{P}(F|G)\mathbb{P}(G)}{\mathbb{P}(F|G)\mathbb{P}(G) + \mathbb{P}(F|\neg G)\mathbb{P}(\neg G)}.
\]
> If $\mathbb{P}(G) \ge \mathbb{P}(\neg G)$, we can deduce the required 
> conclusion that $\mathbb{P}(G|F) > \mathbb{P}(\neg G|F)$, but we are 
> otherwise left in doubt.

From this snappy argument he concludes
> Bayesianism therefore has an explanation of why religious folk are more 
> ready to accept the argument by design than skeptics!

As an atheist with Bayesian tendencies, I was very ready to accept this argument against the argument by design, but upon reflection I think this conclusion is arrived at too quickly. 

Since we are computing probabilities anyway, why stop at checking if one is just larger than the other when we can compute odds?

Rather than just ask whether $\mathbb{P}(G|F) > \mathbb{P}(\neg G|F)$ we can compute the odds $\mathbb{P}(G|F)/\mathbb{P}(\neg G|F)$ and see how far it is from 1. Specifically,
\[\displaystyle
\frac{\mathbb{P}(G|F)}{\mathbb{P}(\neg G|F)}
= \frac{\mathbb{P}(F|G)\mathbb{P}(G)}{\mathbb{P}(F|\neg G)\mathbb{P}(\neg G)}
= \frac{\mathbb{P}(F|G)}{\mathbb{P}(F|\neg G)}
  \cdot\frac{\mathbb{P}(G)}{\mathbb{P}(\neg G)}
\]
since the denominator in Binmore's calculation is just $\mathbb{P}(F)$ -- the probability that "something appears to have been organized" and is assumed to be the same for believer and skeptic alike.

Now we see that the argument by design increases one's belief in God given that organisation is observed (since we have assumed $\mathbb{P}(F|G) > \mathbb{P}(F|\neg G)$) but will only "convert" a non-believer to a believer if the likelihood ratio for God is larger than the non-believer's initial skepticism, as measured by his or her subjective odds against God's existence.[^1] That is, if
\[\displaystyle 
L = \frac{\mathbb{P}(F|G)}{\mathbb{P}(F|\neg G)} > 
\frac{\mathbb{P}(\neg G)}{\mathbb{P}(G)} = R.
\]

The strength of the argument by design is a function of the likelihood ratio $L$ of observing organised things with and without assuming a God.

However, contrary to Binmore's conclusion, I believe the real reason ID advocates and skeptics disagree as to the strength of the argument by design is due to differences in this likelihood ratio.

It is fair to assume, as Binmore does, that the the likelihood ratio $L_r$ for an ID advocate and the likelihood ratio $L_s$ of a skeptic are both greater than 1 since there are many man-made artefacts such as watches that clearly do have an "organizer". However, I would additionally argue that $L_r > L_s$. Why? Well, presumably a skeptic who belies in evolution sees the natural world as a whole lot of things that were organised without an organiser whereas the ID advocate does not.

An ID advocate with a large $L_r$ will believe that even if you were very skeptical (small $R$), the product of $L_r$ and $R$ would be much larger than 1 and you would therefore be convinced to believe in God. From the point of view of a skeptic though $L_s$ would not be larger than $R$ and so the argument by design is not convincing.

[^1]: This type of updating is what [Richard Jeffrey][rj] evocatively called "probability kinematics" and is otherwise known as [Jeffrey Conditioning][jc].

[rj]: http://en.wikipedia.org/wiki/Richard_Jeffrey
[jc]: http://plato.stanford.edu/entries/bayes-theorem/#4
