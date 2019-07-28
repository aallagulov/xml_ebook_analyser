#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;
use Pod::Usage;
use XML::LibXML;
use XML::LibXML::XPathContext;
use Data::Dumper;

my ($file);

GetOptions(
    'file=s' => \$file,
);
$file or pod2usage("Please specify (-f|--file) to work with\n");

my $dom = XML::LibXML->load_xml(location => $file);
my $full_text = $dom->textContent();

my ($non_space_text, $normalized_text) = ($full_text, $full_text);
$non_space_text =~ s/\s//g;
say length($non_space_text);

my @normalized_lines = map {s/^\s+|\s+$//;$_} grep {/\w/} split("\n", $normalized_text);
say length(join("",@normalized_lines)); 

my $href_nodelist = $dom->getElementsByTagName("a");
say $href_nodelist->size();

