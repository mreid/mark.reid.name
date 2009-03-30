--- 
title: COLT 2008 Highlights
excerpt: A quick summary of some of the best talks and papers at COLT 2008 in Helsinki, Finland.
location: Canberra, Australia

layout: iem-post

wordpress_url: http://conflate.net/inductio/?p=46
wordpress_id: 46
---
I'm a little late to the party since several machine learning bloggers have already noted their favourite papers at the recent joint [ICML][]/[UAI][]/[COLT][] conferences in Helsinki. 

[John][] listed a few COLT papers he liked, [Hal][] has covered some tutorials as well as several ICML and a few UAI and COLT papers, while [Jurgen][] has given an overview of the [non-parametric Bayes workshop][npbayes] workshop.

[icml]: http://icml2008.cs.helsinki.fi/
[uai]: http://uai2008.cs.helsinki.fi/
[colt]: http://colt2008.cs.helsinki.fi/

[john]: http://hunch.net/?p=341
[hal]: http://nlpers.blogspot.com/2008/07/icmluaicolt-2008-retrospective.html
[jurgen]: http://undirectedgrad.blogspot.com/2008/07/npbayes-workshop-at-icml.html
[npbayes]: http://undirectedgrad.blogspot.com/2008/07/npbayes-workshop-at-icml.html

I didn't make it to the main ICML sessions but I did catch the workshop on evaluation in machine learning. Since I've already [written about][evaluation] that and didn't attend any of the UAI sessions, I'll focus on the COLT stuff I found interesting.

[evaluation]: http://conflate.net/inductio/2008/07/evaluation-methods-for-machine-learning/

The joint COLT/UAI invited talks were all excellent and covered a diverse range of topics. [Robin Hanson][] gave a great introduction to prediction markets. It was clear he'd given this type of talk before as he handled the many subsequent questions directly and decisively. I'm really interested in the work being done here so I'll write more about prediction markets in a later post. 

[robin hanson]: http://hanson.gmu.edu/home.html

[Gábor Lugosi][] talkcovered a number of important concentration inequalities, focusing on the logarithmic Sobolev inequalities.  It was a perfect example of a maths talk where details were eschewed without compromising accuracy in order to give insight into the main results. 

[gábor lugosi]: http://www.econ.upf.es/~lugosi/

[Dan Klein][] presented some impressive results pertaining to the unsupervised learning in three natural language problems: grammar refinement (inventing new annotations to improve parsing), coreference resolution (determining which nouns refer to the same thing) and lexicon translation (matching words across languages). By setting up simple Bayesian models and throwing a ton of unlabelled examples at them he was able to get results competitive with the best supervised learning approaches on some problems. 

The lexicon translation was particularly impressive. Given a set of English documents and a set of Chinese documents his system was able to do a passable job of translating single words between the language. What was impressive is that there was no information saying that, for example, this English document is a translation of that Chinese document. They could have all been pulled randomly from .co.uk and .cn sites. 

If I understand it correctly, Klein's system simply looked for common patterns of words within documents of one language and then tried to match those patterns to similar patterns in the documents of the other. When the languages were "closer" - such as with Spanish and English - the system also made use of patterns of letters within words (e.g., "<i>direc</i>tion" and "<i>direc</i>ción") to find possible cognates. 

[Dan Klein]: http://www.cs.berkeley.edu/~klein/

There was a variety of good papers at COLT this year. Of the talks I saw, two stood out for me.

[The True Sample Complexity of Active Learning][balcan_hanneke] by Balcan, Hanneke and Wortman showed the importance of choosing the right theoretic model for analysis. In active learning the learner is able to choose which unlabelled examples have their labels revealed. 
Intuitively, one would think that this should make learning easier than the normal supervised learning where the learner has no say in the matter. 

Previous results showed that this was basically not the case. Subtly, those results asked that the active learner achieve a certain error rate but also _verify_ that that rate was achieved. What Nina and her co-authors showed was that if you remove this extra requirement then active learning does indeed make learning much easier, often with exponential improvements in sample complexity over "passive" learning.

[balcan_hanneke]: http://colt2008.cs.helsinki.fi/papers/108-Balcan.pdf

[An Efficient Reduction of Ranking to Classification][ailon] by Ailon and Mohri was also impressive. They build on earlier work that showed how a ranking problem can be reduced to learning a binary preference relation between the items to be ranked. One crucial part of this reduction is turning a learnt preference relation into a ranking. That is, taking pair-wise assessments of relative item quality and laying out all those items along a line so as to best preserve those pair-wise relationships. 

What Ailon and Mohri show is that simply applying a randomised quicksort to the pair-wise comparisons for n items will give a good reduction to a ranking in O(n log n) time. "Good" here means that the regret of the reduction-based ranking over the best possible is bounded by the regret of the classifier that learns the preference relation over the best possible classification. Furthermore, if you are only interested in the top k of n items you can get a good ranking in O(k log k + n) time. What's particularly nice about this work is the tools they use to analysis randomised quicksort are very general and will probably find other applications.

[ailon]: http://colt2008.cs.helsinki.fi/papers/32-Ailon.pdf

Finally, while I didn't attend the talk at COLT, a couple of people have told me that Abernethy et al.'s paper [Competing in the Dark: An Efficient Algorithm for Bandit Linear Optimization][abernethy] was very good. I've since skimmed through it and it is a very nice paper, well-written and replete with interesting connections. I'm not that familiar with bandit learning work but this paper is has a good summary of recent results and is intriguing enough to make me want to investigate further.

[sridharan]: http://colt2008.cs.helsinki.fi/papers/94-Sridharan.pdf 
[abernethy]: http://colt2008.cs.helsinki.fi/papers/123-Abernethy.pdf

