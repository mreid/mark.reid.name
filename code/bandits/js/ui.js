function running_totals(rewards) {
    var totals = [];
    var reward = 0;            
    for(var t=0 ; t < rewards.length ; t++) {
        reward += rewards[t];
        totals.push([t+1,reward]);
    } 
    return totals;        
}

function running_average(rewards) {
    var totals = [];
    var reward = 0;            
    for(var t=0 ; t < rewards.length ; t++) {
        reward += rewards[t];
        totals.push([t+1,reward/(t+1)]);
    } 
    return totals;
}

function plotRewards(fn, rewards, options) {
    var plot = { lines: {show: true}, shadowSize: 0, lineWidth: 1 };
    for(opt in options) { plot[opt] = options[opt]; }
    plot.data = fn(rewards);
    return plot;
}

// Returns plot markings for an agent, if appropriate.
// Currently, just plots epoch transitions for Exp3.1 in light blue
function agentMarkings(agent) {
    var marks = [];
    if(agent.epochs !== undefined) {
        var epochs = agent.epochs();
        for(var e=0 ; e < epochs.length ; e++) {
            marks.push( 
                { color: '#99f', lineWidth: 1, 
                  xaxis: { from: epochs[e], to: epochs[e] }}
            );
        }
    }
    return marks;
}

var banditTypes = {
    name: 'bandit',
    types: {
        "Bernoulli": { constructor: Bandit.Bernoulli, args: [ 0.1 ] }            
    },
    defaults: [
        [ 'Bernoulli', 0.1 ],
        [ 'Bernoulli', 0.3 ],
        [ 'Bernoulli', 0.8 ]
    ]
}
var agentTypes = {
    name: 'agent',
    types: {
        "Random": { constructor: Agent.Random },
        "UCB1": { constructor: Agent.UCB1 },
        "Exp3": { constructor: Agent.Exp3, args: [0.1] },
        "Exp3.1": { constructor: Agent.Exp31 },
        "Exp3.S": { constructor: Agent.Exp3S, args: [0.1, 0.002] },
    },
    defaults: [ 
        [ 'Exp3.1' ]
    ]
}

function runGame() {
    var steps = $('#steps').val();
    var bandits = builder(banditTypes);
    var agents = builder(agentTypes);
    var markings = [];

    var fn;
    var yaxis;
    if($('#average:checked').val()) {
        fn = running_average;
        yaxis = { min: 0, max: 1 }; 
    } else {
        fn = running_totals;
    }
    
    Game(agents, bandits).run(steps);
    
    // Plot agents
    var plots = [ ];
    for(var a=0 ; a < agents.length ; a++) {
        var agent = agents[a];
        plots.push(plotRewards(fn, agent.rewards, { label: agent.name }));
        markings = markings.concat(agentMarkings(agents[a]));
    }
    
    // Plot bandits
    var banditColor = 'rgba(127,127,127,0.6)';
    for(var b=0 ; b < bandits.length ; b++) { 
        var bandit = bandits[b];
        plots.push(plotRewards(fn, bandit.rewards, {color: banditColor}));
    }

    // Draw it!
    $.plot(
        $("#placeholder"), 
        plots, 
        { // yaxis: { min: 0, max: 1}, 
          legend: { position: "se" },
          yaxis: yaxis,
          grid: { markings: markings } }
    );        
}
    
function builder(kind) {
    var objs = [];
    $('.'+kind.name+' select').each(function(i){
        var constructor = kind.types[$(this).val()].constructor;
        var args = [];
        $(this).next('.args').find('input').each(function(j) {
            args.push($(this).val());
        });
        objs.push(constructor.apply(this,args));
    });
    return objs;
}

function makeNew(kind) {
    return $('<a/>')
        .text('+ create').attr('href', '')
        .click(function(event) {
            event.preventDefault();
            $(this).before(makeSelector(kind));
        });
}

function makeList(kind) {
    var list = $('ol#'+kind.name);
    for(var i = 0 ; i < kind.defaults.length ; i++) {
        var selector = makeSelector(kind);
        selector.find('select').val(kind.defaults[i][0]);
        selector.find('input').each(function(j) {
            $(this).val(kind.defaults[i][j+1]);
        });
        list.append(selector);
    }
    list.append(makeNew(kind));
    return list;
}

function makeSelector(kind) {
    var li = $("<li/>").addClass(kind.name);
    var select = $("<select/>");
    for(type in kind.types) {
        var option = $('<option/>').val(type).text(type);
        select.append(option);
        select.change(function(event) {
            var value = $(this).val();
            $(this).next('.args').replaceWith(makeArgs(kind,value));
        });
    }
    li.append(select);
    li.append($('<div/>').addClass('args'));
    select.change();
    return li;
}

function makeArgs(kind,type) {
    var args = $('<div/>').addClass('args').css('display', 'inline');
    var properties = kind.types[type];
    if(properties && properties.args) {
        properties.args.forEach(function(arg) {
            args.append('<input type="text" size="5" value="'+arg+'"/>');
        });
    }
    return args;
}
