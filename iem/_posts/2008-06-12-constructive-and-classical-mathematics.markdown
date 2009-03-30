--- 
layout: iem-post
title: Constructive and Classical Mathematics
location: Canberra, Australia

excerpt: A simple example involving irrational numbers makes me think that constructive mathematics has something going for it.

wordpress_id: 42
wordpress_url: http://conflate.net/inductio/?p=42

---
I have a (very) amateur interest in the philosophy of mathematics. My interest was recently piqued again after finishing the very readable "[Introducing Philosophy of Mathematics][ipom]" by Michèle Friend. Since then, I've been a lot more aware of terms like "constructivist", "realist", and "formalist" as they apply to mathematics.

Today, I was flicking through the entry on "[Constructivist Mathematics][cm]" in the [Stanford Encyclopedia of Philosophy][seop] and found a simple example of some of the problems with non-constructive take on what disjunction means in mathematical statements. The article calls it "well-worn" but I hadn't seen it before.

Consider the statement:
> There exists irrational numbers a and b such that a<sup>b</sup> is rational.

The article gives a slick proof that this statement is true by invoking the [law of the excluded middle][lem] (LEM). That is, every number must be either rational or irrational. 

Now consider $\sqrt{2}^{\sqrt{2}}$.  By the LEM, this must rational or irrational:

  * Case 1: If it is rational then we have proved the statement since we know $a = b = \sqrt{2}$ is irrational. 

  * Case 2: If $\sqrt{2}^{\sqrt{2}}$ is irrational then choosing $a = \sqrt{2}^{\sqrt{2}}$ and $b = \sqrt{2}$ as our two irrational numbers gives ${\sqrt{2}^{\sqrt{2}^{\sqrt{2}}}} = {\sqrt{2}^2} = 2$ -- a rational number. 

Either way, we've proven the existence of two irrational numbers yielding a rational one.
The problem with this is that this argument is non-constructive and so we don't know which of case 1 and case 2 is true, we only know that one of them must be[^1]. This is a simple case of <i>reductio ad absurdum</i> in disguise.

As a born-again computer scientist (my undergraduate degree was pure maths and my PhD in computer science) I've become increasingly suspicious of these sorts of proof and more [constructivist][] -- even [intuitionist][] -- in my tastes. I think the seed of doubt was planted during the awkward discussions of the [Axiom of Choice][] in my functional analysis lectures. The sense of unease is summed up nicely in the following joke:

> The Axiom of Choice is obviously true, the well-ordering principle obviously false, 
> and who can tell about Zorn's lemma?

Of course, all those concepts are equivalent but that's far from intuitive.

I don't think I'm extremist enough to take a wholeheartedly computational view of mathematics -- denying all but the computable real numbers and functions, thereby making [all functions continuous][] -- but it is a tempting view of the subject.

In machine learning, I think there is a fairly pragmatic take on the philosophy of mathematics. For example, classical theorems from functional analysis are used to derive results involving kernels but when it comes to implementation, estimations and approximations are used with abandon. In my opinion, this is a [healthy way for the theory in this area to proceed][lemire]. As in physics, if the experimental work reveals inconsistencies with a theory, revisit the maths. If that doesn't work, [talk to the philosophers][dim].

[ipom]: http://www.librarything.com/work/3362656/book/17581191
[cm]: http://plato.stanford.edu/entries/mathematics-constructive/
[seop]: http://plato.stanford.edu/
[lem]: http://en.wikipedia.org/wiki/Law_of_the_excluded_middle
[intuitionist]: http://en.wikipedia.org/wiki/Intuitionism
[constructivist]: http://en.wikipedia.org/wiki/Constructivism_%28mathematics%29
[axiom of choice]: http://en.wikipedia.org/wiki/Axiom_of_choice
[all functions continuous]: http://math.andrej.com/2006/03/27/sometimes-all-functions-are-continuous/
[lemire]: http://www.daniel-lemire.com/blog/archives/2008/06/05/why-pure-theory-is-wasteful/
[dim]: http://diveintomark.org/archives/2008/06/11/purity

[^1]: It turns out that, by [Gelfond's Theorem](http://en.wikipedia.org/wiki/Gelfond's_theorem) that $\sqrt{2}^{\sqrt{2}}$ is transcendental, and therefore irrational so the second case alone proves the statement. However, I'm not sure what machinery is required to prove Gelfond's theorem.

