---
layout: name
section: Code
title: Bandits Demo
---

Multi-armed Bandit Demo
=======================

This is a simple JavaScript demonstration of some algorithms for the multi-armed
bandit problem. 

Some background, references, and information about the bandit problem can be found at 
my [GitHub](http://github.com/mreid/Bandits/) repository, along with the source code.

<table id="controls" style="border: 1px solid gray;padding: 1ex;width:100%;">
    <tr style="text-align:left;">
        <th>Bandits</th>
        <th>Agents</th>
    </tr>
    <tr>
        <td style="vertical-align: top; width: 40%;">
            <ol id="bandit">
                
            </ol>
        </td>

        <td style="vertical-align: top; width: 40%;">
            <ol id="agent">
                
            </ol>
        </td>
        <td style="vertical-align: top;">
            Run game for
            <input id="steps" type="text" value="500" size="4"/>
            <label for="steps">steps</label>.<br/>
            <button id="run">Go!</button><br/>
            <label for="average">Average</label>:
            <input id="average" type="checkbox" checked="true" />
        </td>
    </tr>
</table>

<div id="placeholder" style="margin:0 auto;width:600px;height:300px;text-align:center;border: 1px solid gray;">
</div>

Running the Demo
----------------
Bandits and agents can
be chosen using the drop-down selections. New bandits and agents can be added by
clicking the "+ create" link. If a bandit or agent requires parameters these can
be added in the text areas which appear next to the drop-down menu.

Once the bandits and agents are selected, the number of steps for the game can 
be entered in the text field on the right. Then hit "Go!" to run the game. 

The results are plotted below the UI. Rewards for bandits are drawn in light
grey, agents are in colour and are listed in the plot's legend. (The "Averages"
check box determines whether running totals or averages are displayed).

<div>
<script src="js/lib/jQuery.js" type="text/javascript"> </script>
<script src="js/lib/jquery.flot.min.js" type="text/javascript"> </script>
<script src="js/bandits.js" type="text/javascript"> </script>
<script src="js/agents.js" type="text/javascript"> </script>
<script src="js/ui.js" type="text/javascript"> </script>

<script type="text/javascript">
$(document).ready(function(){        
    $('ol #bandit').replaceWith(makeList(banditTypes));
    $('ol #agent').replaceWith(makeList(agentTypes));
    $("#run").click(runGame);
});
</script>
</div>