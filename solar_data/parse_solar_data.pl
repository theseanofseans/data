#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long qw(GetOptions);

our $HELP= 0;
our $CLASS= 1;
our $ALL_CLASSES= 0;

GetOptions(
	'all-classes' => \$ALL_CLASSES , 
	'class=i' => \$CLASS , 
	'help' => \$HELP
);

my $data_file= shift || die "USAGE: data_file \n";

my $fh;
die "ERROR: can't open data_file($data_file) : $!\n" if (!open($fh,$data_file));

my @all= ();
my @data= ();
my @class= ();
while (my $line= <$fh>) {
	@all= split(/\s+/,$line);
	@data= @all[0..9];
	@class= @all[10..12];
	if ($ALL_CLASSES) {
	} else {
		print "$class[$CLASS-1] ";
	}
	map {print $_+1 . ":" . ord($data[$_]) . " " } (0..2);
	map {print $_+1 . ":$data[$_] " } (3..$#data);
	print "\n";
}

