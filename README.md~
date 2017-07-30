# financial-planning
A temporal metric financial PDDL planning domain and problem w/ tools for personal planning.  Extremely simple proof of concept to be expanded upon.

To use:

# Clone the repository
cd financial-planning
./tsimple-20170801-hack-redacted.sh

If everything worked the output should be in HTML in:

tmp/projected-transactions.html


To modify:

Currently you have to change around the planning problem in:

pddl/tsimpleopticclp20170801exampleredacted.p.pddl

The way this system works for now, in order to generate the HTML output, 
is to generate the temporal plan and then coax it into a nontemporal plan, 
and then walk the nontemporal plan through VAL to get the changing metric 
values and then reapply the temporal information.  This is a temporary 
hack.

So in order to get the HTML output you have to edit both the temporal 
problem in:

pddl/tsimpleopticclp20170801exampleredacted.p.pddl

and then copy that and strip out temporal assertions (i.e. statements in 
the init section like (at <TIME> <FLUENT), etc) and put into the nontemporal
problem here:

scripts/temporal_to_sequential/tsimpleopticclp20170801_sequential.p.pddl

Please note that as of this writing (20170730) the part that does that 
automatically is also not finished.

Also, please note that the resulting plan is very simple, but if you 
introduce additional agents and have complex financial situations it 
can very easily get complicated.  The point of this system is to make 
it easier to do financial what-if scenarios.  For instance even very 
complex domains have been solved in 0.2 seconds.  The Free Life Planner
is going to use this in combination with WOPR and other planning systems
to try to make life planning easier for people.  This is imagined to be
of most assistance to people experiencing poverty, homelessness, illness 
and or disabilty.

See: 

http://facebook.com/frdcsa
http://freelifeplanner.org
http://frdcsa.org/~andrewdo/WebWiki/FreeLifePlanningCoachSoftwareUpdate.html
