#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

$specification = q(
	-f <file>		File
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $file = $conf->{'-f'} || '/tmp/plan.pddl';

my $c = read_file($file);

$c =~ s/.*step\s*//s;
$c =~ s/\s*plan cost.*//s;
$c =~ s/.*Time [\d+\.]+//s;
my @lines = split /\n/, $c;
my $tmp = shift @lines;
my $text = join("\n",@lines);

foreach my $line (split /\n/, $text) {
  $line =~ s/^\s*//s;
  $line =~ s/\s*$//s;
  $line =~ s/: /: \(/;
  $line =~ s/$/\)/;
  $line =~ s/\(\(/\(/;
  $line =~ s/\)$//;
  print $line."\n";
}

# ff: parsing domain file
# domain 'EASY' defined
#  ... done.
# ff: parsing problem file
# problem 'EASY1' defined
#  ... done.


# translating negated cond for predicate PAID
# translating negated cond for predicate OWN
# warning: numeric precondition. turning cost-minimizing relaxed plans OFF.

# ff: search configuration is Enforced Hill-Climbing, then A*epsilon with weight 5.
# Metric is ((1.00*[RF0](TOTAL-ACTIONS)) - () + 0.00)
# COST MINIMIZATION DONE (WITHOUT cost-minimizing relaxed plans).

# Cueing down from goal distance:   16 into depth [1]
#                                   14            [1]
#                                   13            [1]
#                                   12            [1]
#                                   11            [1]
#                                    4            [1][2]
#                                    3            [1][2][3][4][5]
#                                    2            [1][2][3]
#                                    1            [1]
#                                    0            

# ff: found legal plan as follows
# step    0: PAY ONTHETOWN MEREDITHMCGHAN MEREDITHMCGHANSPAYCHECK201707-1
#         1: PAY ONTHETOWN MEREDITHMCGHAN MEREDITHMCGHANSPAYCHECK201707-2
#         2: PAY MEREDITHMCGHAN ELEANORDOUGHERTY TOWARDSRENT20170707
#         3: PAY MEREDITHMCGHAN ILLINOISGOVERNMENT TRANSFEROFCAR
#         4: PAY HELPATHOME ANDREWDOUGHERTY ANDREWDOUGHERTYSPAYCHECK20170714
#         5: PAY ANDREWDOUGHERTY CRICKETWIRELESS BILLCRICKET201707
#         6: PAY ELEANORDOUGHERTY ANDREWDOUGHERTY TOWARDSSERVER
#         7: PAY ANDREWDOUGHERTY ELEANORDOUGHERTY TOWARDSRENT20170707
#         8: PAY JESSBALINT ANDREWDOUGHERTY TOWARDSBILLCOMCAST201707
#         9: PAY MEREDITHMCGHAN ANDREWDOUGHERTY TOWARDSBILLCRICKET201707
#        10: PAY MEREDITHMCGHAN ANDREWDOUGHERTY TOWARDSBILLCOMCAST201707
#        11: PAY ELEANORDOUGHERTY ANDREWDOUGHERTY TOWARDSBILLCRICKET201707
#        12: PAY ANDREWDOUGHERTY COMCASTBUSINESS BILLCOMCAST201707
#        13: OBTAIN-PERMISSION-FOR-LOAN-FROM ANDREWDOUGHERTY JOSEPHDOUGHERTY MISCELLANEOUSSUPPLIES
#        14: PAY JOSEPHDOUGHERTY ANDREWDOUGHERTY MISCELLANEOUSSUPPLIES
#        15: BUY ANDREWDOUGHERTY GOODSERVER
# plan cost: 16.000000

# time spent:    0.00 seconds instantiating 2926 easy, 0 hard action templates
#                0.00 seconds reachability analysis, yielding 2946 facts and 1473 actions
#                0.00 seconds creating final representation with 2944 relevant facts, 4364 relevant fluents
#                0.20 seconds computing LNF
#                0.24 seconds building connectivity graph
#                0.32 seconds searching, evaluating 142 states, to a max depth of 5
#                0.76 seconds total time

