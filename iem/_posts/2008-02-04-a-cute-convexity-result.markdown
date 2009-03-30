--- 
layout: iem-post
title: A Cute Convexity Result
location: Canberra, Australia

excerpt: A quick post on the use of determinants to define convex functions.

wordpress_id: 23
wordpress_url: http://conflate.net/inductio/theory/a-cute-convexity-result/

---
Just when I thought I was starting to get my head around the multitudinous uses of convexity in statistics I was thrown by the following definition:

> A function f over the interval (a,b) is convex if, for all choices of {x,y,z} 
> satisfying a < x < y < z < b the determinant 
>
> \[ \left| \begin{matrix} 1 & 1 & 1 \\ x & y & z \\ f(x) & f(y) & f(z) \end{matrix}\right|\]
>
> is non-negative.

After expanding the determinant and some algebraic twiddling I realised that this is just a very compact way of requiring that
\[
	\frac{z-y}{z-x} f(x) + \frac{y-x}{z-x}f(z) \geq f(y)
\] 
which, after noticing that (z-y) + (y-x) = (z-x), of course is the more traditional way of saying a function is convex.

What's neat about this determinant representation is that it extends nicely to what are known as k<sup>th</sup>-order convex functions (ones whose derivatives up to order k are convex). Specifically, f is k-convex whenever $\{x_i\}_{i=0}^{k+1}$ satisfy $a < x_0 < \ldots < x_{k+1} < b$ and 
\[
\left| 
       \begin{matrix}
          1    & \cdots & 1 \\ 
          x_0 & \cdots & x_{k+1} \\ 
          x_0^2 & \cdots & x_{k+1}^2 \\
          \vdots & \ddots & \vdots \\
          x_0^k & \cdots & x_{k+1}^k \\
          f(x_1) &  \cdots & f(x_{k+1}) 
     \end{matrix} \right| \geq 0.
\]

While it is arguably less transparent than explicitly writing out all the convexity inequalities for each of the derivatives of f it certainly makes up for it with compactness.