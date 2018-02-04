# financial-planning
A temporal metric financial PDDL planning domain and problem w/ tools for personal planning.  Extremely simple proof of concept to be expanded upon.  Can be used as a subplanner to analyze what if scenarios, such as if you were to buy this or that.  Can also be used to arrive at a final plan, and contingency plans for if unexpected expenses arise.

Here is an example which took 0.2 seconds to compute:


<h3>PROJECTED TRANSACTIONS FOR: Florence Tucker</h3>
<table border="1" cellpadding="10">
<tr><td style="padding: 5px"><b>Date sortable sorted in descending order</b></td><td style="padding: 5px"><b>Ref/Check No Description</b></td><td style="padding: 5px"><b>Debit sortable</b></td><td style="padding: 5px"><b>Credit sortable</b></td><td style="padding: 5px"><b>Balance</b></td></tr>
<tr><td style="padding: 5px">2018/08/25 00:01:26</td><td style="padding: 5px">HOME HELP INC FLORENCETUCKERSPAYCHECK20180825</td><td style="padding: 5px"></td><td style="padding: 5px">233.00</td><td style="padding: 5px">397.01</td></tr>

<tr><td style="padding: 5px">2018/08/11 20:21:07</td><td style="padding: 5px">OMNICORP BUSINESS BILLOMNICORP201808</td><td style="padding: 5px">-140.00</td><td style="padding: 5px"></td><td style="padding: 5px">164.01</td></tr>

<tr><td style="padding: 5px">2018/08/11 20:19:40</td><td style="padding: 5px">LOCUST WIRELESS BILLLOCUST201808</td><td style="padding: 5px">-110.00</td><td style="padding: 5px"></td><td style="padding: 5px">304.01</td></tr>

<tr><td style="padding: 5px">2018/08/11 16:42:14</td><td style="padding: 5px">RANDI MCBRIDE TOWARDSBILLOMNICORPFROMRANDIMCBRIDE201808</td><td style="padding: 5px"></td><td style="padding: 5px">30.00</td><td style="padding: 5px">414.01</td></tr>

<tr><td style="padding: 5px">2018/08/11 16:40:48</td><td style="padding: 5px">RANDI MCBRIDE TOWARDSBILLLOCUSTFROMRANDIMCBRIDE201808</td><td style="padding: 5px"></td><td style="padding: 5px">25.00</td><td style="padding: 5px">384.01</td></tr>

<tr><td style="padding: 5px">2018/08/11 03:37:26</td><td style="padding: 5px">RANDI MCBRIDE TOWARDSRENTFROMFLORENCETUCKER201808</td><td style="padding: 5px">-116.00</td><td style="padding: 5px"></td><td style="padding: 5px">359.01</td></tr>

<tr><td style="padding: 5px">2018/08/11 00:00:00</td><td style="padding: 5px">HOME HELP INC FLORENCETUCKERSPAYCHECK20180811</td><td style="padding: 5px"></td><td style="padding: 5px">466.00</td><td style="padding: 5px">475.01</td></tr>

<tr><td style="padding: 5px">2018/08/00 02:26:52</td><td style="padding: 5px">GEEKBUYINGDOTCOM MECOOL GEEKBUYINGDOTCOM</td><td style="padding: 5px">-35.99</td><td style="padding: 5px"></td><td style="padding: 5px">9.01</td></tr>

</table>


<h3>PROJECTED TRANSACTIONS FOR: Randi McBride</h3>
<table border="1" cellpadding="10">
<tr><td style="padding: 5px"><b>Date sortable sorted in descending order</b></td><td style="padding: 5px"><b>Ref/Check No Description</b></td><td style="padding: 5px"><b>Debit sortable</b></td><td style="padding: 5px"><b>Credit sortable</b></td><td style="padding: 5px"><b>Balance</b></td></tr>
<tr><td style="padding: 5px">2018/08/15 03:37:26</td><td style="padding: 5px">JOHANNA STEIN TOWARDSRENTFROMJOHANNASTEIN201808</td><td style="padding: 5px"></td><td style="padding: 5px">100.00</td><td style="padding: 5px">2203.61</td></tr>

<tr><td style="padding: 5px">2018/08/11 16:42:14</td><td style="padding: 5px">FLORENCE TUCKER TOWARDSBILLOMNICORPFROMRANDIMCBRIDE201808</td><td style="padding: 5px">-30.00</td><td style="padding: 5px"></td><td style="padding: 5px">2103.61</td></tr>

<tr><td style="padding: 5px">2018/08/11 16:40:48</td><td style="padding: 5px">FLORENCE TUCKER TOWARDSBILLLOCUSTFROMRANDIMCBRIDE201808</td><td style="padding: 5px">-25.00</td><td style="padding: 5px"></td><td style="padding: 5px">2133.61</td></tr>

<tr><td style="padding: 5px">2018/08/11 16:39:21</td><td style="padding: 5px">AMERICANEXPRESS BILLAMERICANEXPRESS201808</td><td style="padding: 5px">-27.00</td><td style="padding: 5px"></td><td style="padding: 5px">2158.61</td></tr>

<tr><td style="padding: 5px">2018/08/11 03:37:26</td><td style="padding: 5px">FLORENCE TUCKER TOWARDSRENTFROMFLORENCETUCKER201808</td><td style="padding: 5px"></td><td style="padding: 5px">116.00</td><td style="padding: 5px">2185.61</td></tr>

<tr><td style="padding: 5px">2018/08/09 00:00:00</td><td style="padding: 5px">EVERETT INDUSTRIES RANDIMCBRIDEPAYCHECK201808</td><td style="padding: 5px"></td><td style="padding: 5px">2011.00</td><td style="padding: 5px">2069.61</td></tr>

<tr><td style="padding: 5px">2018/08/02 03:41:45</td><td style="padding: 5px">CITYOFCHICAGOWATERDEPARTMENT BILLCITYOFCHICAGOWATER201808</td><td style="padding: 5px">-60.00</td><td style="padding: 5px"></td><td style="padding: 5px">58.61</td></tr>

<tr><td style="padding: 5px">2018/08/02 03:40:19</td><td style="padding: 5px">FOXMETRO BILLFOXMETRO201808</td><td style="padding: 5px">-30.00</td><td style="padding: 5px"></td><td style="padding: 5px">118.61</td></tr>

<tr><td style="padding: 5px">2018/08/02 03:38:52</td><td style="padding: 5px">ELEMENTGAS BILLELEMENTGAS201808</td><td style="padding: 5px">-16.00</td><td style="padding: 5px"></td><td style="padding: 5px">148.61</td></tr>

<tr><td style="padding: 5px">2018/08/02 03:37:26</td><td style="padding: 5px">SPOTON BILLSPOTON201808</td><td style="padding: 5px">-25.00</td><td style="padding: 5px"></td><td style="padding: 5px">164.61</td></tr>

<tr><td style="padding: 5px">2018/08/02 00:00:00</td><td style="padding: 5px">CLEVERMARTINDUSTRIES RANDIMCBRIDEPENSION201808</td><td style="padding: 5px"></td><td style="padding: 5px">175.95</td><td style="padding: 5px">189.61</td></tr>

<tr><td style="padding: 5px">2018/08/00 20:19:40</td><td style="padding: 5px">TREATURITEHEALTHCARE BILLTREATURITEHEALTHCAREPREMIUM201808</td><td style="padding: 5px">-235.75</td><td style="padding: 5px"></td><td style="padding: 5px">13.66</td></tr>

<tr><td style="padding: 5px">2018/08/00 02:29:45</td><td style="padding: 5px">GOODENERGIES BILLGOODENERGIES201808</td><td style="padding: 5px">-283.59</td><td style="padding: 5px"></td><td style="padding: 5px">249.41</td></tr>

<tr><td style="padding: 5px">2018/08/00 02:26:52</td><td style="padding: 5px">BRYANTANDALEXANDRIAPAUL BILLRENT201808</td><td style="padding: 5px">-1400.00</td><td style="padding: 5px"></td><td style="padding: 5px">533.00</td></tr>

</table>


<h3>PROJECTED TRANSACTIONS FOR: Johanna Stein</h3>
<table border="1" cellpadding="10">
<tr><td style="padding: 5px"><b>Date sortable sorted in descending order</b></td><td style="padding: 5px"><b>Ref/Check No Description</b></td><td style="padding: 5px"><b>Debit sortable</b></td><td style="padding: 5px"><b>Credit sortable</b></td><td style="padding: 5px"><b>Balance</b></td></tr>
<tr><td style="padding: 5px">2018/08/15 03:37:26</td><td style="padding: 5px">RANDI MCBRIDE TOWARDSRENTFROMJOHANNASTEIN201808</td><td style="padding: 5px">-100.00</td><td style="padding: 5px"></td><td style="padding: 5px"></td></tr>

<tr><td style="padding: 5px">2018/08/15 00:00:00</td><td style="padding: 5px">UPTOWN JOHANNASTEINSPAYCHECK201808-1</td><td style="padding: 5px"></td><td style="padding: 5px">100.00</td><td style="padding: 5px">100.00</td></tr>

</table>

To use:

Clone the repository, then

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

http://frdcsa.org/~andrewdo/WebWiki/FreeLifePlanner.html

http://facebook.com/frdcsa

http://freelifeplanner.org

http://frdcsa.org/~andrewdo/WebWiki/FreeLifePlanningCoachSoftwareUpdate.html

https://github.com/aindilis/free-life-planner

