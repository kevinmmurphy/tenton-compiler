#!/usr/bin/perl
#
# a perl script for creating C++ source code from markup
#
use strict;
use warnings;

use ClassNode;
package main;
#
#check number of arguments 
# 
my $x = @ARGV;
if ( $x != 1) {
    print "Usage: $0 <filename>";
    exit;
} 


#
# get filename and open it
#
my $allines;
my $filename = $ARGV[0];
open(INPUT, $filename) or die "Couldn't open input file \'$filename\', $!";

#
# remove all comments and newlines
#
while (<INPUT>)
{
     if ( /^([^#]+)?(#.+)*$/ && defined($1)) {
 	my $line = $1;
	chomp($line);
       	$allines = $allines . $line;	
     }
}
# 
# create class objects
#
if ( $allines =~ /class\s+(\S+)\s*(\{.+\};)/ )
{
    #print "$1 $2";
    my $cls = new ClassNode($1,$2);
    $cls->parse();
} 


#print "$allines";
print "\n";
