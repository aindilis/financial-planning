#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $c1 = read_file('/tmp/val.out');
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
foreach my $line (split /\n/, $c2) {
  if ($step > -1) {
    if ($line =~ /Updating (.+?) \(([\d\.]+)\) by ([\d\.]+) (increase|decrease|assignment)/) {
      if (! exists $steps->[$step]) {
	$steps->[$step] = [];
      }
      my $hash =
	{
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
      push @{$steps->[$step]}, $hash;
    }
  }
  if ($line =~ /Checking next happening \(time ([\d\.]+)\)/) {
    $step = $1;
  }
}

# pretty print


my $i = 0;
my $avaiablebalance = {};
foreach my $step (@$steps) {
  my $title = $step->[0]{Step};
  print $i++." After $title\n";
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
    print "\t".
      $hash->{Fluent}.' '.
      $hash->{StartingAmount}.' --> '.
      $hash->{EndingAmount}.' ('.
      $hash->{Direction}.' of '.
      $hash->{AbsValueOfChange}.
      ')'."\n";
    $avaiablebalance->{$hash->{Fluent}} = $hash->{EndingAmount};
  }
  print "\n";
}

print "\n";
foreach my $fluent (sort keys %$avaiablebalance) {
  next if $fluent =~ /(helpAtHome|cricketWireless|comcastBusiness|illinoisGovernment|josephDougherty|jessBalint|onTheTown)/i;
  print $avaiablebalance->{$fluent}."\t".$fluent."\n";
}
print "\n";
