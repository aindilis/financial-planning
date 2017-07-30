#!/bin/bash

set -x

ROOTDIR=`pwd`

FILE1=$ROOTDIR/tmp/plan.optic-clp.pddl

FILE2=$ROOTDIR/tmp/tsimpleopticclp20170801.p.pddl.OPTIC_CLP.sol

# verber -p OPTIC_CLP -w finance/current/tsimpleopticclp20170801 | tee > $FILE1 2>/dev/null
$ROOTDIR/bin/optic-clp -N $ROOTDIR/pddl/tsimpleopticclp20170801exampleredacted.d.pddl $ROOTDIR/pddl/tsimpleopticclp20170801exampleredacted.p.pddl > $FILE2

$ROOTDIR/scripts/plan-postprocessor.pl -f $FILE2 > $ROOTDIR/tmp/plan.sol.pddl 2> /dev/null

# $ROOTDIR/bin/ff -o $ROOTDIR/data-git/pddl/finance/current/easy.d.pddl -f $ROOTDIR/data-git/pddl/finance/current/easy.p.pddl

# /var/lib/myfrdcsa/codebases/internal/verber/data/planner-library/lpg-td-1.0 -o $ROOTDIR/data-git/pddl/finance/current/easy.d.pddl -f $ROOTDIR/data-git/pddl/finance/current/easy.p.pddl -out pddl/finance/current/easy.p.pddl.LPG.sol -speed

## $ROOTDIR/bin/validate -v /var/lib/myfrdcsa/codebases/internal/verber/data-git/worldmodel/worlds/finance/current/tsimpleopticclp20170801.d.pddl /var/lib/myfrdcsa/codebases/internal/verber/data-git/worldmodel/worlds/finance/current/tsimpleopticclp20170801.p.pddl $ROOTDIR/tmp/plan.sol.pddl > $ROOTDIR/tmp/val.out

$ROOTDIR/scripts/convert-temporal-plan-to-sequential-plan-for-hack.pl -i $ROOTDIR/tmp/plan.sol.pddl -o $ROOTDIR/tmp/plan-seq-converted.sol.pddl -m $ROOTDIR/tmp/mapping.dat

# swipl -s convert-temporal-to-sequential-for-hack.pl

$ROOTDIR/bin/validate -v $ROOTDIR/scripts/temporal_to_sequential/tsimpleopticclp20170801_sequential.d.pddl $ROOTDIR/scripts/temporal_to_sequential/tsimpleopticclp20170801_sequential.p.pddl $ROOTDIR/tmp/plan-seq-converted.sol.pddl > $ROOTDIR/tmp/val.out

$ROOTDIR/scripts/val-postprocess-statement.pl -f $ROOTDIR/tmp/val.out -m $ROOTDIR/tmp/mapping.dat -sth > $ROOTDIR/tmp/projected-transactions.html

cat $ROOTDIR/tmp/projected-transactions.html
