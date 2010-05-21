---
title: Prediction Services

excerpt: Thoughts on a number of recent prediction services including the Google Prediction API.

location: Canberra, Australia

layout: iem-post

---

I have been thinking about learning and prediction as services for some time now. Like all good ideas, they tend to be thought of independently by several people when their time is ripe. Therefore I was not completely surprised when I heard the [news][] yesterday that Google has released a new RESTful [prediction API][google]. 

As a couple of other bloggers ([John][], [Panos][]) have already noted, this is very exciting as it has the potential of making statistical inference a commodity and putting machine learning tools in the hands of everyday developers.

Using the API
-------------
The details are a little scant as the API is not yet open to the public at the moment but, as the [FAQ][] and [sample code][] explain, it appears to work as follows:

 1. A data set in CSV format is uploaded to [Google storage][]. This can contain up to 100 million rows of text or numeric features. Each row can be associated with one of up to several hundred classes.
 
 2. The URL obtained after uploading the data set is POSTed to a second URL, `/prediction/v1/train/DATA_ID`, for Google's learning algorithm (all URLs are relative to `https://googleapis.com`). It is not clear what algorithms are being used behind the scenes for this step but the home page says the API will automatically choose from a variety of techniques.
 
 3. The training occurs asynchronously and its progress can be queried by issuing a GET to `/prediction/v1/query/DATA_ID`. Once training is completed, this query will return a cross-validated estimate of the learned model's accuracy.
 
 4. To make a new prediction with the trained model, a POST request containing the data to classify is sent to the `/prediction/v1/query/DATA_ID` URL and a label prediction is returned.

Although this is a relatively simple API and, at present, only deals with classification, I believe it has the potential to cover a large proportion of most web developers' prediction needs (e.g., text classification, sentiment analysis, click-through analysis) as well as several scientific applications.

Related Projects
----------------
The Google Prediction API is not the first to offers inferential services over the web but I do think they are the first to focus on building reusable predictors and to do it with a clean API design.

Some other projects offering prediction services include:

 * [uClassify][] --- This is probably the closest existing service to Google's. It also provides an API for training and predicting but, upon a cursory examination, appears a bit more complicated than the Google prediction API. I believe the [main algorithm](http://www.uclassify.com/Products.aspx) used by uClassify is a variant of naïve Bayes.

 * [MLcomp][] --- This recently announced service is more aimed at machine learning researchers and provides a convenient way to compare several algorithms on a selection of data sets  using a variety of metrics. Unlike Google's offering, MLcomp does not make the trained predictors available via an API and focuses more on providing easily repeatable experiments. One nice thing about the MLcomp service is that anyone is free to upload learning algorithms provided they implement a simple [calling pattern](http://mlcomp.org/help/program_info.html).
 
 * [predict][i2pi] --- A simpler MLcomp-like service built by [Joshua Reich](http://i2pi.com/team.html) that lets users upload CSV files to learn from and/or snippets of [R]() code to run. Once again, the aim is to evaluate algorithms rather than train predictors for subsequent use.
 
 * [TunedIT][] --- Similar to MLcomp and i2pi's _predict_, this service aims to make comparing learning algorithms across data sets easier. As far as I can tell, it does not offer an API for running learners and predictors over the web but rather offers users the ability to create data-mining [challenges](http://tunedit.org/challenges/docs) that other users can compete within.

 * [ExpDB][] --- This is not so much a service as a growing database of experimental results but I thought I'd include it here as it has a similar focus to the last three projects. The main innovation here is the creation of a language -- [ExpML](http://expdb.cs.kuleuven.be/expdb/expml.php?tq=) -- for describing and querying the parameters, algorithms, data sets and results of machine learning experiments. 

 * [RL-Glue][rlglue] --- While not about prediction _per se_, this somewhat older project is related as it offers an API for defining reinforcement learning problems that can be solved in a programming language-independent way.

Of course, there are also many machine learning toolkits such as [Weka][], [Orange][], [Elefant][], [Rattle][] and more that provide implementations of algorithms, but these do not offer them as services.

Future Predictions
------------------
Over the last few years we've seen a [dramatic increase][economist] in the amount of data being generated and made available over the web (e.g., [Freebase][], [DBpedia][], [Data.gov][datagov], [Netflix][], and [protein databases][protein]). Also, thanks to services by Google, Amazon and others, there has also been a large-scale commodification of computational power and storage.

There are a handful of companies at present --- [Flightcaster][], for example --- who have realised that there is immense opportunity at the intersection of these developments to start applying large-scale machine learning. Hopefully, what the Google Prediction API and other services will provide is the spark for an explosion of new and creative approaches to distilling knowledge from raw information.

I will be watching how this all unfolds with great interest.

[google]: http://code.google.com/apis/predict/
[news]: http://googlecode.blogspot.com/2010/05/bigquery-and-prediction-api-get-more.html
[faq]: http://code.google.com/apis/predict/docs/faq.html
[sample code]: http://code.google.com/apis/predict/docs/samples.html
[google storage]: http://code.google.com/apis/storage/
[mlcomp]: http://mlcomp.org
[delve]: http://www.cs.toronto.edu/~delve/index.html
[i2pi]: http://predict.i2pi.com/
[tunedit]: http://tunedit.org/
[rlglue]: http://glue.rl-community.org/
[uclassify]: http://www.uclassify.com/
[expdb]: http://expdb.cs.kuleuven.be/expdb/index.php
[panos]: http://behind-the-enemy-lines.blogspot.com/2010/05/google-prediction-api-commoditization.html#comments
[john]: http://hunch.net/?p=1383
[economist]: http://www.economist.com/opinion/displayStory.cfm?story_id=15579717&source=hptextfeature

[weka]: http://www.cs.waikato.ac.nz/ml/weka/
[orange]: http://www.ailab.si/orange/
[elefant]: http://elefant.developer.nicta.com.au/
[rattle]: http://rattle.togaware.com/
[flightcaster]: http://flightcaster.com/

[freebase]: http://www.freebase.com/
[dbpedia]: http://dbpedia.org/
[datagov]: http://www.data.gov/
[netflix]: http://www.netflix.com/
[protein]: http://www.ncbi.nlm.nih.gov/protein