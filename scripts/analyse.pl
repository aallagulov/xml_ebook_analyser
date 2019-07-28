#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;
use Pod::Usage;
use XML::LibXML;
use Data::Dumper;

my ($file);

GetOptions(
    'file=s' => \$file,
);
$file or pod2usage("Please specify (-f|--file) to work with\n");

my $dom = XML::LibXML->load_xml(location => $file);
# my $nodes = $dom->findnodes('//FictionBook ');  
# print $nodes->size() . "\n";

# for my $node ($nodes->get_nodelist()) {
#     print $node->nodeName . "\n";
# }
my $text = '';
for my $nodes ($dom->findnodes('/')) {
	say ref($nodes);
	$text .= $nodes->to_literal();
}
say $text;
$text =~ s/\s//g;
say $text;