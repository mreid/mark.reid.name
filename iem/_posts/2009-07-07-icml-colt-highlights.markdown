---
title: ICML and COLT Highlights

excerpt: I attended both ICML and COLT this year. This is an overview of what I thought were the most interesting talks.

location: Canberra, Australia

layout: iem-post

---

Now that I have had a much needed holiday I am feeling refreshed enough to write up some of my notes on the recent [ICML][] and [COLT][] conferences held in Montréal this year.

[icml]: http://www.cs.mcgill.ca/~icml2009/
[colt]: http://www.cs.mcgill.ca/~colt2009/

I did not get to see as much of either conference as I would have liked to as I was nursing an awful cold. Fortunately, I was able to fight it off long enough to finish and give my [ICML and COLT presentations][mine]. The ICML one almost didn't happen as I had completely lost my voice the day before.

[mine]: /iem/generalised-pinsker-inequalities.html

ICML
----

One theory paper I really liked at ICML was _[PAC-Bayesian Learning of Linear Classifiers][pac-bayes]_ by Pascal Germain, Alexandre Lacasse, [François Laviolette][laviolette] and [Mario Marchand][marchand]. They give a general statement of the PAC-Bayes bound in terms of a convex function measuring the divergence between the true and empirical risks and, most importantly, give a remarkably simple proof using only Markov and Jensen's inequalities.

[pac-bayes]: http://conflate.net/icml/paper/2009/89
[laviolette]: http://www2.ift.ulaval.ca/~laviolette/
[marchand]: http://www2.ift.ulaval.ca/~mmarchand/

Although I didn't really follow the active learning aspects of _[Learning from Measurements in Exponential Families][measurements]_ by [Percy Liang][liang], [Dan Klein][klein] and [Michael Jordan][jordan], I did think their introduction of _measurements_ as a way of combining labels and constraints was elegant. Rather than assuming instances _X_ have observed labels _Y_, they assume the labels are hidden and their values are only available implicitly through a set of aggregated measurements _M(X,Y)_ over the whole data set. Various choices of the function _M_ result in many existing learning problems.

[measurements]: http://conflate.net/icml/paper/2009/393
[liang]: http://www.eecs.berkeley.edu/~pliang/
[jordan]: http://www.cs.berkeley.edu/~jordan
[klein]: http://www.cs.berkeley.edu/~klein

COLT
----
Of the presentations I managed to attend at COLT, there were two that I found thought-provoking. 

_[Learnability and Stability in the General Learning Setting][general-learning]_ by [Shai Shalev-Shwartz][shai], [Ohad Shamir][ohad], [Nathan Srebro][nati] and [Karthik Sridharan][karthik] examined the "general learning setting" proposed by Vapnik where, instead of trying to minimising the expected cost of a function that predicts labels for instances $\mathbb{E}[\ell(h(X), Y)]$ we just want to find a point $h$ in a hypothesis space $\mathcal{H}$ that minimises $\mathbb{E}[\ell(h, Z)]$. The relationship between hypotheses and instances in the latter case is much more arbitrary than in the usual supervised setting. 

Interestingly, the usual correspondence between uniform convergence of empirical risks to the expected risk and learnability which holds for supervised learning with empirical risk minimisation (ERM) breaks down in the general setting. In particular, it turns out uniform convergence is sufficient for learning with ERM but not necessary. The authors therefore explore generalised notions of ERM and show that learnability and stability are equivalent for these more general versions.

[general-learning]: http://ttic.uchicago.edu/~shai/papers/ShalevShamirSridharanSrebro2.pdf

[shai]: http://ttic.uchicago.edu/~shai/
[ohad]: http://www.cs.huji.ac.il/~ohads03/
[nati]: http://ttic.uchicago.edu/~nati/
[karthik]: http://ttic.uchicago.edu/~karthik/

Finally, I really liked the connections made between online learning and traditional statistical learning theory in _[A Stochastic View of Optimal Regret through Minimax Duality][minimax]_ by [Jacob Abernethy][abernethy], [Alekh Agarwal][agarwal], [Peter Bartlett][bartlett] and [Alexander Rakhlin][rakhlin]. In this paper the authors use the von Neumann's minimax theorem to relate the minimax regret that is normally used in online convex optimisation (OCO) games to a supremum over a set of distributions of the expectations of a loss. Through a neat geometrical interpretation of this loss they are able to establish upper and lower bounds on the optimal regret for various online learning problems.

[minimax]: http://arxiv.org/abs/0903.5328

[abernethy]: http://www.eecs.berkeley.edu/~jake/
[agarwal]: http://www.eecs.berkeley.edu/~alekh/
[bartlett]: http://www.stat.berkeley.edu/~bartlett/
[rakhlin]: http://www-stat.wharton.upenn.edu/~rakhlin/

More Highlights
---------------

If you are after more highlights, I recommend having a look at [John][] and [Hal][]'s overviews of the conferences.

[john]: http://hunch.net/?p=813
[hal]: http://nlpers.blogspot.com/2009/06/icmlcoltuai-2009-retrospective.html
