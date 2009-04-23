---
title: A Taxonomy of Generalisation Bounds

excerpt: In an effort to understand the many and varied generalisation bounds in statistical learning theory I have compiled a taxonomy of them.

layout: iem-post

---

If, like me, you have spent any time reading through recent machine learning literature in journals like [JMLR][] or conference proceedings of [ICML][], [NIPS][] and (especially) [COLT][] you almost certainly would have come across generalisation bounds. 

These are statements like this fragment from Agarwal and Niyogi's [recent paper][an2009] on ranking and algorithmic stability: 

> ... with probability at least 1-δ ...
> $$\displaystyle R_{\ell}(f_S) \le \hat{R}_{\ell}(f_S;S) + 2\beta(m) + (m\beta(m)  + B)\sqrt{\frac{2\ln(1/\delta)}{m}}$$

[jmlr]: http://jmlr.csail.mit.edu/
[nips]: http://nips.cc
[colt]: http://learningtheory.org
[icml]: http://machinelearning.org/icml_past.html
[an2009]: http://jmlr.csail.mit.edu/papers/v10/agarwal09a.html

