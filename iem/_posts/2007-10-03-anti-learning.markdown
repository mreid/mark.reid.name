--- 
layout: iem-post
title: Anti-Learning
location: Canberra, Australia

excerpt: A summary of an interesting talk by Justin Bedo which shows that learning can sometimes go very wrong - and how to exploit it.

wordpress_id: 15
wordpress_url: http://conflate.net/inductio/general/anti-learning/

---

Last week I saw an interesting PhD monitoring [presentation][] by [Justin Bedo][] on the
counter-intuitive phenomenon of "anti-learning". For certain datasets, learning a classifier from a small number of samples and inverting its predictions performs much better than the original classifier. Most of the theoretical results Justin mentioned about are discussed in a recent [paper][] and [video lecture][] by [Adam Kowalczyk][]. These build on [earlier work][] presented at ALT 2005. As John notes in his [blog post][] from a couple of years ago, the strangeness of anti-learning is due to our assumption that proximity implies similarity.

This anti-learning effect has been observed in naturally occurring esophageal adenocarcinoma data: a binary classification problem with nearly 10,000 features. In his talk, Justin presented evidence that the effect was real (by constructing a null hypotheses through repeated shuffling of the data labels) and relatively invariant to choice of learning algorithm.

Like any good scientist, Justin and his colleagues replicated the phenomena in a simpler,
synthetic model in order to better understand what might be happening. The model proposed is one that modeling competition between features: if one feature has a large value the others are small but in the opposite direction and examples from different classes have distinct large features pointing in opposite directions. This results in examples from opposite classes being more similar (_i.e._, they have a larger positive inner product) than examples from the same class. At a stretch, this model is also biologically plausible if features are expressions of competing entities in a cell.

The algorithm proposed to deal with anti-learning uses some of the data available at training
time to test whether has anti-learning characteristics and, if so, inverts the resulting
classifier. This "burns" some of the information in the training data but can dramatically
improve performance when anti-learning is correctly identified.

It's an interesting example of a trade-off that can be made between data and background
knowledge. With relatively few examples and the knowledge that you are in an anti-learning situation, you can flip classifications and do very well. As the amount of data available increases, the learning algorithm will converge to a good classifier, the assumption is less valuable and flipping classifications is costly.

[adam kowalczyk]: http://users.rsise.anu.edu.au/~akowalczyk/
[paper]: http://adamk.antilearning.googlepages.com/ecml07.pdf
[video lecture]: http://videolectures.net/mlss06au_kowalczyk_al/
[justin bedo]: http://holly.ath.cx/
[blog post]: http://hunch.net/?p=35
[presentation]: http://cecs.anu.edu.au/seminars/showone.pl?SID=523
[earlier work]: http://www.springerlink.com/content/e3ey7r6yxu68fye6/
