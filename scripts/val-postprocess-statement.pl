#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

use POSIX;
use Text::Capitalize;

$specification = q(
	-s		Separate statements for each user
	-t		Transaction ledger style output
	-h		Transaction ledger style output in HTML

	-m <file>	Mapping file to use

	-f <file>	Optional solution file name
);

my $verbose = 0;
my @ourusers = qw(homersimpson);
my $pp =
  {
   homerSimpson => 'Homer Simpson',
   socialSecurityAdministration => 'Social Security Administration',
   springfieldFitness => 'Springfield Fitness',
   springfieldNuclearPower => 'Springfield NuclearPower',
   landlord => 'landlord',
   springfieldCellular => 'Springfield Cellular',
   springfieldPetroleum => 'Springfield Petroleum',
   springfieldBarber => 'Springfield Barber',
   netflix => 'netflix',
   springfieldAutoInsurance => 'Springfield Auto Insurance',
   springfieldTelecom => 'Springfield Telecom',
   homerSimpsonSocialSecurity => 'Homer Simpsons Social Security',
   billForGym20170708 => 'Bill for Gym 20170708',
   billForPower20170708 => 'Bill for Power 20170708',
   billForRent20170708 => 'Bill for Rent 20170708',
   billForCellPhone201707087 => 'Bill for CellPhone 20170708',
   billForGasoline20170708 => 'Bill for Gasoline 20170708',
   billForHairCut20170708 => 'Bill for HairCut 20170708',
   billForNetflix20170708 => 'Bill for Netflix 20170708',
   billForAutoInsurance20170708 => 'Bill for AutoInsurance 20170708',
   billForLandline20170708 => 'Bill for Landline 20170708',
  };

my $config = BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

if ($conf->{'-h'}) {
  print "<html><body>\n";
}

my $mapping = DeDumperFile($conf->{'-m'});

my $solutionfile = $conf->{'-f'} || '/tmp/val.out';
print "SOL: ".$solutionfile."\n";
my $c1 = read_file($solutionfile);
my $c2 = $c1;
$c1 =~ s/.*Plan size: \d+//s;
$c1 =~ s/Plan Validation details.*//s;

my $step = -1;
my $descs = [];
foreach my $line (split /\n/, $c1) {
  if ($line =~ /^(\d+):$/) {
    $step = $1;
  }
  if ($step > -1) {
    if (! exists $descs->[$step]) {
      $descs->[$step] = [];
    }
    if ($line !~ /^\d+:$/) {
      if ($line =~ /\S/) {
	$descs->[$step] = $line;
      }
    }
  }
}

#######################

$c2 =~ s/.*Plan Validation details//s;
$c2 =~ s/Plan executed successfully - checking goal.*//s;

$step = -1;

my $steps = {};
my $isteps = {};
my $i = 1;
foreach my $line (split /\n/, $c2) {
  if ($step > -1) {
    if ($line =~ /Updating (.+?) \(([\d\.]+)\) by ([\d\.]+) (increase|decrease|assignment)/) {
      if (! exists $steps->{$step}) {
	$steps->{$step} = [];
      }
      my $hash =
	{
	 Count => $i,
	 Step => $descs->[$step],
	 Fluent => $1,
	 StartingAmount => $2,
	 AbsValueOfChange => $3,
	 Direction => $4,
	};
      if ($hash->{Direction} eq 'increase') {
	$hash->{EndingAmount} = $hash->{StartingAmount} + $hash->{AbsValueOfChange};
      } elsif ($hash->{Direction} eq 'decrease') {
	$hash->{EndingAmount} = $hash->{StartingAmount} - $hash->{AbsValueOfChange};
      } elsif ($hash->{Direction} eq 'assignment') {
	$hash->{EndingAmount} = $hash->{AbsValueOfChange};
      }
      print Dumper({Hash => $hash}) if $verbose;
      if ($conf->{'-s'}) {
	my $user;
	foreach my $username (@ourusers) {
	  if ($hash->{Fluent} =~ /\b$username\b/) {
	    $user = $username;
	  }
	}
	if ($user) {
	  if (! exists $isteps->{$user}) {
	    $isteps->{$user} = {};
	  }
	  # print Dumper({Hash => $hash});
	  push @{$isteps->{$user}->{$step}}, $hash;
	  ++$i;
	}
      } else {
	push @{$steps->{$step}}, $hash;
      }
    }
  }
  if ($line =~ /Checking next happening \(time ([\d\.]+)\)/) {
    $step = $1;
  }
}

print Dumper({Steps => $isteps}) if $verbose;
print "<I:$i>\n" if $verbose;
print "<Step:$step>\n" if $verbose;

if ($conf->{'-s'}) {
  # print Dumper({ISteps => $isteps});
  foreach my $user (@ourusers) {
    ProcessSteps
      (
       Steps => $isteps->{$user},
       User => $user,
      );
  }
} else {
  ProcessSteps(Steps => $steps);
}

sub ProcessSteps {
  my (%args) = @_;
  my $bar = '--------------------------------------------------------------------------------------------------------';
  my $mysteps = $args{Steps};
  my $user = $args{User};
  my $prettyusername = Prettify(Text => $user);
  my $i = 0;
  my $availablebalance = {};
  my @sortedkeys = sort {$b <=> $a} keys %$mysteps;
  my $title = $mysteps->{$sortedkeys[0]}[0]{Step};
  my $divider;
  my $prefix;
  my $postfix;
  if ($conf->{'-h'}) {
    $divider = '</td><td style="padding: 5px">';
    $prefix = '<tr><td style="padding: 5px">';
    $postfix = "</td></tr>\n";
  } else {
    $divider = "\t|\t";
    $prefix = '';
    $postfix = '';
  }
  if ($conf->{'-t'}) {
    my $printoutline1 = "PROJECTED TRANSACTIONS FOR: $prettyusername";
    if ($conf->{'-h'}) {
      print "<h3>$printoutline1</h3>\n";
    } else {
      print "\n\n";
    }
    my $legend =
      [
       'Date sortable sorted in descending order',
       'Ref/Check No Description',
       'Debit sortable',
       'Credit sortable',
       'Balance',
      ];

    if ($conf->{'-h'}) {
      my $printoutline2 = $prefix.join($divider,map {'<b>'.$_.'</b>'} @$legend).$postfix;
      print "<table border=\"1\" cellpadding=\"10\">\n$printoutline2";
    } else {
      my $printoutline2 = $prefix.join($divider,@$legend).$postfix;
      print "$printoutline2\n\n$bar\n\n";;
    }
  } else {
    print Dumper
      ({
	TitleKey => $sortedkeys[0],
	Hash => $mysteps->{$sortedkeys[0]},
	Title => $title,
       }) if $verbose;
  }
  print Dumper($mysteps) if $verbose;
  foreach my $key (@sortedkeys) {
    my $step = $mysteps->{$key};
    print $i++." After $title\n" unless $conf->{'-s'};
    foreach my $hash (sort @$step) {
      next if $hash->{Fluent} =~ /\(total-actions\)/;
      if ($hash->{Direction} eq 'assignment') {
	my $change = $hash->{EndingAmount} - $hash->{StartingAmount};
	if ($change < 0) {
	  $hash->{Direction} = 'decrease';
	} else {
	  $hash->{Direction} = 'increase';
	}
	$hash->{AbsValueOfChange} = abs($change);
      }
      if ($conf->{-t}) {
	# print Dumper({Hash => $hash});
	my $desc = $mysteps->{$key}[0]{Step};
	$desc =~ s/\s*\b$user\b\s*/ /sg;
	$desc =~ s/^\(//;
	$desc =~ s/pay-on-time\s*//;
	$desc =~ s/\s*\)$//;
	$desc = Prettify(Text => $desc);
	$desc = join(' ',map {capitalize($_)} split /\s+/, $desc);
	my $debit = 0;
	my $credit = 0;
	if ($hash->{Direction} eq 'decrease') {
	  $debit = '-'.$hash->{AbsValueOfChange};
	}
	if ($hash->{Direction} eq 'increase') {
	  $credit = $hash->{AbsValueOfChange};
	}
	my $balance = $hash->{EndingAmount};
	print Dumper({Count => $hash->{Count}}) if $verbose;
	print Dumper
	  ({
	    Count => $hash->{Count},
	    Key => $key,
	    Mapping => $mapping->{$key},
	    Int => int($mapping->{$key}),
	   }) if $verbose;
       	my $daytime = $mapping->{$key};
	my $day = floor($daytime);
	print Dumper({DayTime => $daytime, Day => $day}) if $verbose;
	my $hourtime = 24.0 * ($daytime - $day);
	my $hour = floor($hourtime);
	my $minutetime = 60.0 * ($hourtime - $hour);
	my $minute = floor($minutetime);
	my $secondtime = 60.0 * ($minutetime - $minute);
	my $second = floor($secondtime);
	print Dumper({Hour => $hour, Minute => $minute, Second => $second}) if $verbose;
	my $entries =
	  [
	   join('/',('2017','08',sprintf("%02d",$day))).' '.join(':',(map {sprintf("%02d",$_)} ($hour,$minute,$second))),
	   uc($desc),
	   $debit ? sprintf("%.2f",$debit) : '',
	   $credit ? sprintf("%.2f",$credit) : '',
	   $balance ? sprintf("%.2f",$balance) : '',
	  ];
	my $printoutline3 = $prefix.join($divider,@$entries).$postfix;
	if ($conf->{'-h'}) {
	  print $printoutline3;
	} else {
	  print $printoutline3."\n";
	}
      } else {
	print "\t".
	  $hash->{Fluent}.' '.
	  $hash->{StartingAmount}.' --> '.
	  $hash->{EndingAmount}.' ('.
	  $hash->{Direction}.' of '.
	  $hash->{AbsValueOfChange}.
	  ')'."\n";
      }
      if (! $conf->{'-s'}) {
	$availablebalance->{$hash->{Fluent}} = $hash->{EndingAmount};
      }
    }
    print "\n";
  }
  if ($conf->{'-s'}) {
    if ($conf->{'-h'}) {
      print "</table>\n\n\n";
    } else {
      print "$bar\n\n\n\n\n";
    }
  } else {
    next if $fluent =~ /(helpAtHome|cricketWireless|comcastBusiness|illinoisGovernment|josephDougherty|jessBalint|onTheTown)/i;
    print $availablebalance->{$fluent}."\t".$fluent."\n";
  }
}

sub Prettify {
  my (%args) = @_;
  foreach my $text (keys %$pp) {
    my $sub = $pp->{$text};
    $args{Text} =~ s/\b$text\b/$sub/sg;
    my $lctext = lc($text);
    $args{Text} =~ s/\b$lctext\b/$sub/sg;
  }
  return $args{Text};
}

if ($conf->{'-h'}) {
  print "</body></html>\n";
}
