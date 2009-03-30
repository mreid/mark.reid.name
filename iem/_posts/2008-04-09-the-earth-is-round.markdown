--- 
title: The Earth Is Round (p &lt; 0.05)
excerpt: Some sage advice by Jacob Cohen on hypothesis testing and p-values.
location: Canberra, Australia

wordpress_url: http://conflate.net/inductio/?p=33
wordpress_id: 33

layout: iem-post
---
I love finding old essays on statistics. The philosophical and methodological wars that rage within that discipline make for fun reading. Particularly enjoyable are those essays - inevitably written by older, well-respected researchers - who make a strong point with beautiful rhetorical flourish and no small amount of barbed humour.

The title of a [journal article][teir] ([PDF][teirpdf]) by Jacob Cohen (and this post) is a classic example. As you may have guessed, it's main aim is to rant against the misuse of p-values for null hypothesis significance testing (NHST). As well as including some extremely amusing quotes by Cohen and others, the paper does a fantastic job of curing the reader of any doubt regarding the correct interpretation of p-values. 

[teir]: http://www.citeulike.org/user/mdreid/article/2643653
[teirpdf]: http://web.math.umt.edu/wilson/Math444/Handouts/Cohen94_earth%20is%20round.pdf

Repeat after me: "the p-value is NOT the probability the null hypothesis is true given the observed data". Or, as Cohen puts it:
> What's wrong with NHST? Well, among many other things, it does not tell us what we want to
> know, and we so much want to know what we want to know that, out of desperation, we
> nevertheless believe that it does! What we want to know is "Given these data, what is the 
> probability that H<sub>0</sub> is true?" But as most of us know, what it tells us is "Given 
> that H<sub>0</sub> is true, what is the probability of these (or more extreme) data?" 
> These are not the same...

Many people make this mistake as it's so easy to erroneously reason about conditional probabilities. The particular fallacy that occurs when p-values are interpreted as the probability the null hypothesis is true is assuming that Prob(H<sub>0</sub>|Data) = Prob(Data|H<sub>0</sub>). Cohen argues that we are confused by the intuitive appeal of reasoning with rare events as though they were impossible events. He highlights why this intuition can led us astray with a wonderful example. A low p-value is erroneously reasoned with as follows:
> If the null hypothesis is correct, then these data are highly unlikely.    
>     These data have occurred.    
>     Therefore, the null hypothesis is highly unlikely.    

This seems, at first glance, to be analogous to the non-probabilistic syllogism (namely _modus tollens_):
> If a person is a Martian, then he is not a member of Congress.    
> This person is a member of Congress.     
> Therefore, he is not a Martian.     

Absolutely nothing wrong with that. It's watertight. Now see what happens when the first line becomes a statement with very high probability instead of strictly true:
> If a person is an American, then he is probably not a member of Congress. (TRUE, RIGHT?)     
> This person is a member of Congress.     
> Therefore, he is probably not an American.

Ouch! That last deduction should have made your eyes water. This is exactly what is going wrong when people misinterpret p-values. It's what you get for using Bayes' rule without knowing something more _unconditionally_ about the probability of being a member of Congress. This is a rare event and its rarity must be factored in when doing the probabilistic equivalent of implication. Similarly, without knowing anything about the prior probability of the null hypothesis you cannot say anything about its posterior probability.

Cohen nicely sums up the danger of treating deduction and induction analogously with a quote attributed to Morris Raphael Cohen:
> All logic texts are divided into two parts. In the first part, on deductive logic, the fallacies are explained; in the second part, on inductive logic, they are committed.


