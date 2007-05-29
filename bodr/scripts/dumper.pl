#!/usr/bin/perl

# Simply dump the data structure of an XML (CML) file

use XML::Simple;
use Data::Dumper;

my $ref = XMLin($ARGV[0]);

print Dumper($ref);
