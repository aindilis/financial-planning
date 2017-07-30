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
