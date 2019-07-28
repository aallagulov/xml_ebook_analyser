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
my $full_text = $dom->textContent();

my ($non_space_text, $normalized_text) = ($full_text, $full_text);
$non_space_text =~ s/\s//g;
say length($non_space_text);

my @normalized_lines = map {s/^\s+|\s+$//;$_} grep {/\w/} split("\n", $normalized_text);
say length(join("",@normalized_lines)); 

my $href_nodes = $dom->getElementsByTagName("a");
say $href_nodes->size();

my $section_nodes = $dom->getElementsByTagName("section");
my $sections = {};
for my $section_node (@$section_nodes) {
	if (my $id = $section_node->getAttribute('id')) {
		$sections->{$id} = undef;  
	}
}
my $broken_links_counter = 0;
foreach my $href_node (@$href_nodes) { 
	my $id_ref_name = $href_node->getAttribute('l:href');
	$id_ref_name =~ s/^\#//;
	unless (exists $sections->{$id_ref_name}) {
		$broken_links_counter++ ;
	}
}  
say $broken_links_counter;
