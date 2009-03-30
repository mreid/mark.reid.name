--- 
title: Evaluation Methods for Machine Learning
excerpt: Some thoughts on the workshop on evaluation methods that I attended as part of ICML 2008 in Helsinki.
location: Canberra, Australia

wordpress_url: http://conflate.net/inductio/?p=45
wordpress_id: 45

layout: iem-post
---
Although I wasn't able to attend the talks at [ICML 2008][] I was able to participate in the [Workshop on Evaluation Methods for Machine Learning][emml] run by William Klement, [Chris Drummond][], and [Nathalie Japkowicz][].

[icml 2008]: http://icml2008.cs.helsinki.fi/
[emml]: http://www.site.uottawa.ca/ICML08WS/
[nathalie japkowicz]: http://www.site.uottawa.ca/~nat/
[chris drummond]: http://www.site.uottawa.ca/~cdrummon/

This workshop at ICML was a continuation of previous workshops held at AAAI that aim to cast a critical eye on the methods used in machine learning to experimentally evaluate the performance of algorithms.

It kicked off with a series of mini debates with Nathalie and Chris articulating the opposing sides. The questions included the following:

 * Should we change how evaluation is done?
 * Is evaluation central to empirical work?
 * Are statistical tests critical to evaluation?
 * Are the UCI data sets sufficient for evaluation?

There were three papers I particularly liked: [Janez Demsar][]'s talk "[On the Appropriateness of Statistical Tests in Machine Learning][appropriateness]", [Edith Law][]'s "[The Problem of Accuracy as an Evaluation Criterion][accuracy]", and [Chris Drummond][]'s call for a mild-mannered revolution "[Finding a Balance between Anarchy and Orthodoxy][anarchy]".

[janez demsar]: http://www.ailab.si/janez/
[appropriateness]: http://www.site.uottawa.ca/ICML08WS/papers/J_Demsar.pdf
[edith law]: http://www.cs.cmu.edu/~elaw/
[accuracy]: http://www.site.uottawa.ca/ICML08WS/papers/E_Law.pdf
[anarchy]: http://www.site.uottawa.ca/ICML08WS/papers/C_Drummond.pdf

Janez's talk touched on a number of criticisms that [I had found in Jacob Cohen's paper "The Earth is Round (p < 0.05)"][round_earth] making the case that people often incorrectly report and incorrectly interpret p-values for statistical tests. Unfortunately, as Janez points out, since machine learning is a discipline that (rightly) places emphasis on results it is difficult as a reviewer to reject a paper that presents an ill-motivated and confusing idea if its authors have shown that, statistically, it outperforms similar approaches.

[round_earth]: http://conflate.net/inductio/2008/04/the-earth-is-round/

Edith's talk argued that accuracy is sometimes a poor measure of performance making all this concern over whether we are constructing statistical tests for it (or AUC) moot. In particular, for tasks like salient region detection in images, language translation and music tagging there is no single correct region, translation or tag. Whether or not a particular region/translation/tag is "correct" or not is impossible to determine independent of the more difficult tasks of image recognition/language understanding/music identification. Solving these for the purposes of evaluation would make a solution to the smaller tasks redundant. Instead of focusing on evaluation of the smaller tasks, Edith suggests ways in which games that humans play on the web -- such as the [ESP Game][] -- can be used to evaluate machine performance on these tasks by playing learning algorithms against humans.

[esp game]: http://www.espgame.org/

Finally, Chris's talk made the bold claim that the way we approach evaluation in machine learning is an "impoverished realization of a controversial methodology", namely statistical hypothesis testing. "Impoverished" because when we do do hypothesis testing it is in the narrowest of senses, mainly to test that my algorithm is better than yours on this handful of data sets. "Controversial" since many believe science to have social, exploratory and accidental aspects --- much more than just the clinical proposing of hypotheses for careful testing.

What these papers and the workshop as a whole showed me was how unresolved my position is on these and other questions regarding evaluation. On the one hand I spent a lot of time painstakingly setting up, running and analysing experiments for my [PhD research][] on inductive transfer in order to evaluate the methods I was proposing. I taught myself how to correctly control for confounding factors, use the [Bonferroni correction][] to adjust significance levels and other esoterica of statistical testing. Applying all these procedures carefully to my work felt very scientific and I was able to create many pretty graphs and tables replete with confidence intervals, p-values and the like. On the other hand -- and with sufficient hindsight -- it's not clear how much value this type of analysis added to the thesis overall (apart from demonstrating to my reviewers that I could do it). 

[phd research]: http://www.library.unsw.edu.au/~thesis/adt-NUN/public/adt-NUN20070512.173744/index.html
[bonferroni correction]: http://en.wikipedia.org/wiki/Bonferroni_correction

The dilemma is this: when one algorithm or approach clearly dominates another details such as p-values, t-tests and the like only obscure the results; and when two algorithms are essentially indistinguishable using "significance" levels to pry them apart seems to be grasping at straws.

That's not to say that we should get rid of empirical evaluation all together. Rather, we should carefully choose (or create) our data sets and empirical questions so as to gain as much insight as possible and go beyond "my algorithm is better than yours". Statistical tests should not mark the end of an experimental evaluation but rather act as a starting point for further questions and carefully constructed experiments that resolve those questions.
