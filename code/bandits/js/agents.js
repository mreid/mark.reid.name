/**
 * agents.js
 *    Mark Reid <mark.reid@gmail.com>
 *    Created: 2010-04-05
 * 
 * Defines a number of agents for playing bandit games within the Agent
 * namespace.
 */

// Some simple utility functions
function sum(array) {
   var result = 0;
   for(var i=0 ; i < array.length ; i++) { result += array[i] }
   return result;
}

function max(array) {
   var result = Number.NEGATIVE_INFINITY;
   for(var i=0 ; i < array.length ; i++) { 
      result = Math.max(result,array[i]); 
   }
   return result;
}

function draw(probs) {
   var x = Math.random();
   var cdf = 0;
   var selected = 0;
   while(x > cdf) { cdf += probs[selected++]; }
   return selected-1;
}

/**
 * All agents must provide the following functions/fields:
 *     name:         A short string description of the agent.
 *     init(k):      Initialise the agent for a k bandit problem.
 *     predict():    Return an index between 0...k-1 as a prediction.
 *     update(r):    Update the agent with reward r.
 *     rewards:      An array of rewards to date.
 *     predictions:  An array of predictions to date.
 */
var Agent = {
   /**
    * The constant prediction algorithm. 
    * Always chooses bandit with index `i`.
    */
   Constant: function(i) {
      var index = i;

      return {
         name: 'Constant('+i+')',
         init: function(num_bandits) { },
         predict: function() {
            this.predictions.push(index);
            return index; 
         },
         update: function(reward) { this.rewards.push(reward); },
         rewards: [],
         predictions: []
      }
   },

   /**
    * An implementation of the UCB1 algorithm from:
    *    P. Auer, N. Cesa-Bianchi, and P. Fischer. 
    *    "Finite-time Analysis of the Multiarmed Bandit Problem." 
    *    Machine Learning, 47, 235-236, 2002.
    */
   UCB1: function() {
      var k = 0;
      var played = [];
      var totals = [];
      var last = 0;

      function score(i,steps) {
         var xbar = totals[i]/played[i];
         var bound = Math.sqrt((2*Math.log(sum(played)))/played[i]);

         return xbar + bound;
      }

      return {
         name: "UCB1",
         init: function(num_bandits) { k = num_bandits; },
         predict: function() {
            var p = 0;
            var steps = this.predictions.length;

            if(played.length < k) {
               p = played.length;
               played[p] = 1;
            } else {
               for(var i=0 ; i<k ; i++) {
                  if(score(i,steps) > score(p,steps)) p = i;
               }
               played[p] += 1;
            }

            this.predictions.push(p);
            last = p;
            return p;
         },
         update: function(reward) {
            this.rewards.push(reward);
            if(totals.length < k) totals[last] = 0;
            totals[last] += reward;
         },
         rewards: [],
         predictions: []
      }
   },

  /**
   * An implementation of the Exp3 algorithm from:
   *    P. Auer, N. Cesa-Bianchi, Y. Freund, and R. Schapire. 
   *    "The nonstochastic multiarmed bandit problem." 
   *    SIAM Journal on Computing, 32(1):48–77, 2002.
   *
   * Returns an Exp3 algorithm initialised with input parameter gamma in (0,1].
   */
   Exp3: function(gamma) {
      var exp3 = Agent.Exp3S(gamma,0);
      exp3.name = "Exp3("+gamma+")";
      return exp3;
   },

   /**
    * An implementation of the Exp3.S algorithm from:
    *    P. Auer, N. Cesa-Bianchi, Y. Freund, and R. Schapire. 
    *    "The nonstochastic multiarmed bandit problem." 
    *    SIAM Journal on Computing, 32(1):48–77, 2002.
    *
    * Returns an Exp3.S algorithm initialised with input parameter 
    * gamma in (0,1] and alpha >= 0.
    *
    * Note that when alpha = 0, this algorithm reduces to the original Exp3.
    */
   Exp3S: function(gamma,alpha) {
      var gamma = gamma;
      var alpha = alpha;
      var weights = [[]];
      var k = 0;

      return {
         name: "Exp3.S("+gamma+","+alpha+")",
         init: function(num_bandits) {
            k = num_bandits;
            for(var i=0 ; i<k ; i++) { weights[0][i] = 1 }
         },
         predict: function() { 
            var p = draw(this.probs());
            this.predictions.push(p);
            return p;
         },
         update: function(reward) {
            this.rewards.push(reward);
            var t1 = weights.length;
            var ws = weights[t1-1];
            var c  = (Math.E * alpha/k)*sum(ws);

            weights[t1] = [];
            for(var i=0 ; i<k ; i++) {
               weights[t1][i] = ws[i];
               if(i === this.predictions[t1-1]) {
                  var xhat = reward/(this.probs()[i]);
                  weights[t1][i] *= Math.exp((gamma*xhat)/k); 
               }
               weights[t1][i] += c;
            }
         },
         probs: function() {
            // Compute a set of probabilities from a set of weights.
            var ws = weights[weights.length-1];
            var total = sum(ws);
            var ps = [];
            for(var i=0 ; i < k ; i++) { 
               ps[i] = (1-gamma)*(ws[i]/total) + gamma/k; 
            }
            return ps;      
         },
         rewards: [],
         predictions: []
      }
   },

   /**
    * An implementation of the Exp3.1 algorithm from:
    *    P. Auer, N. Cesa-Bianchi, Y. Freund, and R. Schapire. 
    *    "The nonstochastic multiarmed bandit problem." 
    *    SIAM Journal on Computing, 32(1):48–77, 2002.
    *
    * Returns an Exp3.1 agent 
    */
   Exp31: function() {
      var   k = 0,            // Number of bandits
            r = 0,            // Current epoch
            exp3 = undefined, // Exp3 subroutine
            totals = [],      // The estimated total reward for each bandit
            epochs = [],      // Which timestep each epoch started
            g = 0,            // Guess for bound 
            gamma = 0;        // Parameter for Exp3 subroutine

      return {
         name: "Exp3.1",
         init: function(num_bandits) { 
            k = num_bandits;
            for(var i=0 ; i < k ; i++) { totals[i] = 0; }
            r = 0;
            g = (k * Math.log(k))/(Math.E-1);
            gamma = 1;
            exp3 = Agent.Exp3(gamma);
            exp3.init(k);
         },
         predict: function() {
            // Update epoch, g and gamma and reset the Exp3 subroutine.
            if(max(totals) > g - k/gamma) {
               r += 1; g *= 4; gamma /= 2;
               epochs.push(this.t());
               exp3 = Agent.Exp3(gamma);
               exp3.init(k);
            }
            var p = exp3.predict();
            this.predictions.push(p);
            return p;
         },
         update: function(reward) {
            this.rewards.push(reward);
            exp3.update(reward);
            totals[this.last()] += reward/(exp3.probs()[this.last()]);
         },
         t: function() { return this.predictions.length; },
         last: function() {
            return this.predictions[this.t()-1];
         },
         epochs: function() { return epochs; },
         rewards: [],
         predictions: []
      }
   },

   /**
    * The random strategy. Chooses a bandit index from a uniform distribution.
    */
   Random: function() {
      var range = 0;

      return {
         name: "Random",
         init: function(num_bandits) { range = num_bandits; },
         predict: function() { 
            var p = Math.floor(Math.random() * range);
            this.predictions.push(p);
            return p;
         },
         update: function(reward) { this.rewards.push(reward) },
         rewards: [],
         predictions: []
      }
   }
};

