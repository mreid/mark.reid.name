--- 
layout: iem-post
title: JMLR Discussion On Boosting
location: Canberra, Australia

excerpt: A summary of a sequence of papers in JMLR that discusses an interpretation of boosting.

wordpress_id: 27
wordpress_url: http://conflate.net/inductio/theory/jmlr-discussion-on-boosting/

---
The upcoming [Volume 9][v9] of the [Journal of Machine Learning Research][jmlr] is dedicated a chunk of its pages to a paper entitled "[Evidence Contrary to the Statistical View of Boosting][mease08a]" by David Mease and Abraham Wyner. Following this is a number of responses by heavyweights including [boosting][]'s earliest proponents, Freund and Schapire, as well as Mease and Wyner's [rejoinder][mease08b] to the responses. The whole conversation is also available in a [single PDF][].

I've seen this format of argument, response and rejoinder a couple of times before in the statistical literature and I think it works really well. It brings the wealth of expert views that are usually found only at workshop or conference panel discussions but adds the benefits of written expression: careful thinking, less time pressure and access to reference material. 

I'm familiar with [AdaBoost][] but haven't really kept up with the recent research surrounding it. It seems that the crux of the discussion is regarding some of the widely held beliefs about the statistical interpretation of boosting (stumps are better than small trees as weak learners, LogitBoost is better than AdaBoost on noisy data). Simple experiments are described which, often surprisingly, contradict the prevailing wisdom. 

Although I have only had time to skim the entire discussion, one thing I've found really impressive about the contrary evidence Mease and Wyner provide is that all the R code for the experiments is [available][r_code]. As can be seen in the subsequent discussion, this provides the responders with concrete reference points and several use them to refine or debate some of the interpretations. This is a perfect example of putting science back into Herbert Simon's [Science of the Artificial][sota], in which he argues that
> Even when the programs themselves are only moderately large and intricate ... 
> too little is known about their task environments to permit accurate prediction of
> how well they will perform. ... Here again theoretical analysis must be 
> accompanied by large amounts of 
> experimental work.

Now that I'm back in the world of academic research, it's high time I revisited some of these foundational algorithms in machine learning. I'm hoping that by reading this discussion on boosting and playing with the experiments I can quickly get up to speed with the area.

[sota]: http://www.librarything.com/work/253126
[r_code]: http://www.davemease.com/contraryevidence/
[boosting]: http://www.boosting.org/
[v9]: http://jmlr.csail.mit.edu/papers/v9/
[jmlr]: http://jmlr.org/
[mease08a]: http://www.jmlr.org/papers/volume9/mease08a/mease08a.pdf
[mease08b]: http://www.jmlr.org/papers/volume9/mease08b/mease08b.pdf
[single pdf]:http://www.jmlr.org/papers/volume9/mease08a/mease08a_with_discussion.pdf
[adaboost]: http://en.wikipedia.org/wiki/AdaBoost
