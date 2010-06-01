---
title: An Invitation to Statistical Learning Theory

excerpt: A brief discussion of an encyclopedia article of mine on generalisation bounds and pointers to a number of introductory articles on learning theory. 

location: Canberra, Australia

layout: iem-post

---

Although I wrote it some time ago, I have been meaning to share an article on generalisation bounds I wrote for the forthcoming [Encyclopedia of Machine Learning][eml]. Although statistical learning theory is more than just the study of these bounds, I find understanding them provides a solid basis for delving into the literature. This is because most learning theory papers will either establish a new bound, use an existing one, or exploit concepts and techniques used in establishing bounds for other purposes.

You can download a PDF of a pre-print version here:

> ![PDF](/files/css/icon_pdf.gif) [Generalization Bounds][bounds] (413kB PDF)

As a taster, the opening paragraphs define generalisation[^1] bounds as follows:

> In the theory of statistical machine learning, a generalization bound—or, more  precisely, a generalization error bound—is a statement about the predictive performance of a learning algorithm or class of algorithms. Here, a learning algorithm is viewed as a procedure that takes some finite training sample of labelled instances as input and returns a hypothesis regarding the labels of all instances, including those which may not have appeared in the training sample. Assuming labelled instances are drawn from some fixed distribution, the quality of a hypothesis can be measured in terms of its risk—that is, its incompatibility with the distribution. The performance of a learning algorithm can then be expressed in terms of the expected risk of its hypotheses given randomly generated training samples. 
>
> Under these assumptions a generalization bound is a theorem which holds for any distribution and states that, with high probability, applying the learning algorithm to a randomly drawn sample will result in a hypothesis with risk no greater than some value. This bounding value typically depends on the size of the training sample, an empirical assessment of the risk of the hypothesis on the training sample as well as the “richness” or “capacity” of the class of predictors that can be output by the learning algorithm.

[^1]: I didn't have a choice regarding the article's title but I prefer the British English spelling of "generalisation".

## Writing For Myself 
The main reasons I agreed to write this paper was a selfish one: I wanted to really understand this stuff. I subscribe to a principle [held](http://www.thevalve.org/go/valve/article/a_david_foster_wallace_syllabus/) by the late David Foster Wallace who draws "no distinction between the quality of one’s ideas and the quality of those ideas’ verbal expression".

I felt the best way to do so was to write up as much of the introductory material as I could. 

(There are many other good introductions but the 12 page limit was a good way to focus on the key ideas)

My aim was to strike a balance between imparting the main intuitions behind the most common bounds and to provide enough technical detail to give some insight into why they are true. I found this a lot more challenging than I first expected...


## Accepting the Invitation
Here is a list of the references, some of which are cited in my article, others are not.

  1. Ulrike von Luxburg and Bernhard Schölkopf, _[Statistical Learning Theory: Models, Concepts, and Results](http://arxiv.org/abs/0810.4752)_, arXiv:0810.4752v1, 2008.
  
  2. Shahar Mendelson, _[A Few Notes on Statistical Learning Theory](http://wwwmaths.anu.edu.au/~mendelso/papers/summer02.pdf)_, In Advanced Lectures on Machine Learning, 2003.
  
  3. John Langford, _[Tutorial on practical prediction theory for classification](http://jmlr.csail.mit.edu/papers/volume6/langford05a/langford05a.pdf)_, Journal of Machine Learning Research, 2005.
  
  4. Stéphane Boucheron, Olivier Bousquet and Gábor Lugosi, _[Theory of classification: A survey of some recent advances](http://www.econ.upf.edu/~lugosi/esaimsurvey.pdf)_, ESAIM: Probability and Statistics, 2005.
  
  5. Olivier Bousquet, Stéphane Boucheron and Gábor Lugosi, _[Introduction to Statistical Learning Theory](http://www.econ.upf.edu/~lugosi/mlss_slt.pdf)_, In Advanced Lectures on Machine Learning, 2004.
  
  6. Ralf Herbrich and Robert C. Williamson, _[Learning and Generalization: Theory and Bounds](http://users.cecs.anu.edu.au/~williams/papers/P158.pdf)_, In the Handbook of Brain Theory and Neural Networks, 2002.


[eml]: http://www.springer.com/computer/ai/book/978-0-387-30768-8
[bounds]: http://dl.dropbox.com/u/38668/Papers/Generalization_Bounds.pdf