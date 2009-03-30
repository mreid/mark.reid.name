--- 
layout: iem-post
title: Prediction and the Axiom of Choice
excerpt: Some thoughts on Hardin and Taylor's paper "A Peculiar Connection Between the Axiom of Choice and Predicting the Future".
location: Canberra, Australia
wordpress_id: 99
wordpress_url: http://conflate.net/inductio/?p=99
---
A curious paper entitled ["A Peculiar Connection Between the Axiom of Choice and Predicting the Future"][paper] by [Christopher Hardin][hardin] and [Alan Taylor][taylor] caught my attention recently via the blog [XOR's Hammer][xor].

[paper]: http://maven.smith.edu/~chardin/pub/peculiar.pdf
[hardin]: http://maven.smith.edu/~chardin/
[taylor]: http://www.math.union.edu/people/faculty/taylora.html
[xor]: http://xorshammer.wordpress.com/2008/08/23/set-theory-and-weather-prediction/

Its main claim is that there exists an almost infallible prediction strategy. That is, one that will almost always predict the correct present value of some unknown function given all its past values. More specifically, they describe the µ-strategy which, when given the values of a function v for all points in time up to but not including t, correctly predicts the value of v(t) for all but countably many points t. They also show that this same strategy can almost always extrapolate correctly into the future (i.e., correctly predict v(s) for t ≤ s < t + ε).

"Well", you think, "that's induction solved then. I'm going to grab that paper, implement that strategy and retire on the immense wealth I will accumulate from the stock market." Unfortunately for your bank balance, the authors note that
> We should emphasize that these results do not give a practical means of predicting 
> the future, just as the time dilation one would experience standing near the event 
> horizon of a black hole does not give a practical time machine.

In other words, the result is purely theoretical. Worse than that, the definition of the µ-strategy requires the [well-ordering theorem][] --- otherwise known as the [Axiom of Choice][]. 

[well-ordering theorem]: http://en.wikipedia.org/wiki/Well-ordering_theorem
[axiom of choice]: http://en.wikipedia.org/wiki/Axiom_of_choice

Aside from being completely non-constructive the µ-strategy is relatively straight-forward. First, using the well-ordering theorem, choose some ordering of the set of all possible functions. Now, for each point in time t denote by \[v\]<sub>t</sub> the equivalence class of functions that are equal for all -∞ < s < t. When presented with the values for some unknown v up to time t the µ-strategy simply chooses the "smallest" member, say u, of \[v\]<sub>t</sub> with respect to the ordering and outputs u(t).

So, apart for the bit where you have to invoke the well-ordering theorem to order the set of all functions over the reals, it's a very simple strategy.

The author's suggest that the chosen well-ordering can be thought of as a measure of simplicity. In this case the µ-strategy just chooses the "simplest" function consistent with the observations to date. More generally, the well-ordering can be thought of as a bias for the strategy. Different choices of bias will lead to different predictions based on the same past observations. What's odd about the result is that *no matter what bias is chosen the µ-strategy will only ever make countably many mistakes*.

Ultimately, the [intuitionist][] in me looks upon this result much as I see the [Banach-Tarski paradox][]. That is, as evidence against the use of the axiom of choice (and its equivalents) in mathematics that's even vaguely practical. Still, the result is an interesting one that analyses the problem of induction in a very abstract setting.

[banach-tarski paradox]: http://en.wikipedia.org/wiki/Banach-Tarski_paradox
[intuitionist]: http://conflate.net/inductio/2008/06/constructive-and-classical-mathematics/
