/**
 * Bandits provide the following functions:
 *    name:    a short string describing the bandit
 *    reward:  a function returning a reward in [0,1]
 *    rewards: an array of rewards returned reward()
 *    total:   the current sum of rewards returned by reward()  
 */
var Bandit = {
   /**
    * Construct a bandit that returns a reward of 1 with probability p and 
    * zero otherwise.
    */
   Bernoulli: function(p) {
      var p = p;

      return {
         name: "Bernoulli("+p+")",
         reward: function() {
            var v = 1 && ( Math.random() < p ) || 0 ;
            this.rewards.push(v);
            this.total += v;
            return v;
         },
         rewards: [],
         total: 0
      }
   }
}

/**
 * A bandit game.
 *    run(steps): Runs the game for the given number of steps.
 */
function Game(agents, bandits) {
   var agents = agents;
   var bandits = bandits;
   
   return {
      run: function(steps) {
         // Initialise all the agents
         for(var a=0 ; a<agents.length ; a++) { 
            agents[a].init(bandits.length); 
         }

         // Play the game for the required number of steps
         for(var t=0 ; t<steps ; t++) {

            // Compute all the rewards
            var rewards = [];
            for(var b=0 ; b<bandits.length ; b++) {
               rewards[b] = bandits[b].reward();
            }
            
            // Get the agents' predictions and give rewards
            for(var a=0 ; a<agents.length ; a++) {
               var choice = agents[a].predict();
               var reward = rewards[choice];
               agents[a].update(reward);               
            }
         }
      }
   }
}