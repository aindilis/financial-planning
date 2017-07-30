#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

$specification = q(
	-i <file>		Input Plan File
	-o <file>		Output Plan File
	-m <file>		Mapping File
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

die "No -i specified\n" unless exists $conf->{'-i'} and -f $conf->{'-i'};
die "No -o specified\n" unless exists $conf->{'-o'};
die "No -m specified\n" unless exists $conf->{'-m'};

my $c = read_file($conf->{'-i'});

# print $c."\n";

my @lines;
my $i = 1;
my $mapping = {};
foreach my $line (split /\n/, $c) {
  if ($line =~ /^([\d\.]+): (\(.+?\))\s+\[([\d\.]+)\]$/) {
    my $time = $1;
    my $statement = $2;
    my $duration = $3;
    my $newstatement = $statement;
    # $newstatement =~ s/pay-on-time/pay/sg;
    $mapping->{$i} = $time;
    push @lines, $i++.': '.uc($newstatement);
  } else {
    die "wtf\n";
  }
}

WriteFile
  (
   File => $conf->{'-o'},
   Contents => join("\n",@lines),
  );

WriteFile
  (
   File => $conf->{'-m'},
   Contents => ClearDumper($mapping),
  );
