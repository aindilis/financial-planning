Number of literals: 41
Constructing lookup tables: [10%] [20%] [30%] [40%] [50%] [60%] [70%] [80%] [90%] [100%]
Post filtering unreachable actions:  [10%] [20%] [30%] [40%] [50%] [60%] [70%] [80%] [90%] [100%]
(total-actions) has a finite lower bound: [0.000,inf]
(balance socialsecurityadministration) has a finite upper bound: [-inf,10001.000]
(balance springfieldfitness) has a finite lower bound: [10001.000,inf]
(balance springfieldnuclearpower) has a finite lower bound: [10001.000,inf]
(balance landlord) has a finite lower bound: [10001.000,inf]
(balance springfieldcellular) has a finite lower bound: [10001.000,inf]
(balance springfieldpetroleum) has a finite lower bound: [10001.000,inf]
(balance springfieldbarber) has a finite lower bound: [10001.000,inf]
(balance netflix) has a finite lower bound: [10001.000,inf]
(balance springfieldautoinsurance) has a finite lower bound: [10001.000,inf]
(balance springfieldtelecom) has a finite lower bound: [10001.000,inf]
Have identified that bigger values of (balance homersimpson) are preferable
Have identified that bigger values of (balance socialsecurityadministration) are preferable
[01;34mNo analytic limits found, not considering limit effects of goal-only operators[00m
Action 0 - (pay-on-time homersimpson springfieldautoinsurance billforautoinsurance20170708) is uninteresting once we have fact (paid homersimpson springfieldautoinsurance billforautoinsurance20170708)
Action 1 - (pay-on-time homersimpson springfieldcellular billforcellphone20170708) is uninteresting once we have fact (paid homersimpson springfieldcellular billforcellphone20170708)
Action 2 - (pay-on-time homersimpson springfieldpetroleum billforgasoline20170708) is uninteresting once we have fact (paid homersimpson springfieldpetroleum billforgasoline20170708)
Action 3 - (pay-on-time homersimpson springfieldfitness billforgym20170708) is uninteresting once we have fact (paid homersimpson springfieldfitness billforgym20170708)
Action 4 - (pay-on-time homersimpson springfieldbarber billforhaircut20170708) is uninteresting once we have fact (paid homersimpson springfieldbarber billforhaircut20170708)
Action 5 - (pay-on-time homersimpson springfieldtelecom billforlandline20170708) is uninteresting once we have fact (paid homersimpson springfieldtelecom billforlandline20170708)
Action 6 - (pay-on-time homersimpson netflix billfornetflix20170708) is uninteresting once we have fact (paid homersimpson netflix billfornetflix20170708)
Action 7 - (pay-on-time homersimpson springfieldnuclearpower billforpower20170708) is uninteresting once we have fact (paid homersimpson springfieldnuclearpower billforpower20170708)
Action 8 - (pay-on-time homersimpson landlord billforrent20170708) is uninteresting once we have fact (paid homersimpson landlord billforrent20170708)
[i] Not abstracting out TIL (okay)
[i] Not abstracting out TIL (can billforgym20170708)
[i] Not abstracting out TIL (can billforpower20170708)
[i] Not abstracting out TIL (can billforrent20170708)
[i] Not abstracting out TIL (can billforcellphone20170708)
[i] Not abstracting out TIL (can billforgasoline20170708)
[i] Not abstracting out TIL (can billforhaircut20170708)
[i] Not abstracting out TIL (on-time billfornetflix20170708)
[i] Not abstracting out TIL (can billfornetflix20170708)
[i] Not abstracting out TIL (on-time billforautoinsurance20170708)
[i] Not abstracting out TIL (can billforautoinsurance20170708)
[i] Not abstracting out TIL (on-time billforlandline20170708)
[i] Not abstracting out TIL (can billforlandline20170708)
All the ground actions in this problem are compression-safe
Initial heuristic = 16.000, admissible cost estimate 0.000
b (15.000 | 0.000)b (14.000 | 0.100)b (12.000 | 0.251)b (11.000 | 0.403)b (10.000 | 0.405)b (9.000 | 0.407)b (8.000 | 0.409)b (7.000 | 0.411)b (6.000 | 0.413)b (5.000 | 12.000)b (4.000 | 12.150)b (3.000 | 17.000)b (2.000 | 17.150)b (1.000 | 22.000)(G);;;; Solution Found
; States evaluated: 20
; Cost: 22.151
; Time 0.02
0.102: (pay-on-time socialsecurityadministration homersimpson homersimpsonsocialsecurity)  [0.150]
0.254: (pay-on-time homersimpson landlord billforrent20170708)  [0.150]
0.256: (pay-on-time homersimpson springfieldnuclearpower billforpower20170708)  [0.150]
0.258: (pay-on-time homersimpson springfieldbarber billforhaircut20170708)  [0.150]
4.847: (pay-on-time homersimpson springfieldfitness billforgym20170708)  [0.150]
6.846: (pay-on-time homersimpson springfieldpetroleum billforgasoline20170708)  [0.150]
6.847: (pay-on-time homersimpson springfieldcellular billforcellphone20170708)  [0.150]
12.000: (pay-on-time homersimpson netflix billfornetflix20170708)  [0.150]
17.002: (pay-on-time homersimpson springfieldautoinsurance billforautoinsurance20170708)  [0.150]
22.001: (pay-on-time homersimpson springfieldtelecom billforlandline20170708)  [0.150]
