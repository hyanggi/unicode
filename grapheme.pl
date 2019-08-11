#!/usr/bin/env perl

use strict;
use warnings;

use open ':locale';
use charnames ':full';
use Unicode::UCD 'charprop';

sub print_cpinfo {
	my $codepoint = $_[0];

	my $cpdesc = sprintf "\e[32m%x", ord $codepoint;

	my $cpname = charnames::viacode(ord $codepoint);
	if (defined $cpname) {
		$cpname = lc $cpname;
	}
	else {
		$cpname = 'unknown';
	}
	$cpdesc .= "\e[36m \e[35m" . $cpname;

	my $cpcate = lc charprop(ord $codepoint, 'Gc');
	$cpdesc .= "\e[36m \e[35m(" . $cpcate . ')';

	print "\e[36m<", $cpdesc, "\e[36m>\e[0m";
}

while (<>) {
	chomp;
	my @graphemes = split /\b{g}/;
	foreach my $grapheme(@graphemes) {
		print $grapheme, ':';
		my @codepoints = split //, $grapheme;
		foreach my $codepoint(@codepoints) {
			print '  ';
			if ($codepoint =~ /^\pC$/) {
				printf 'N/A';
			}
			elsif ($codepoint =~ /^\pM$/) {
				printf "\x{25cc}%s", $codepoint;
			}
			else {
				printf '%s', $codepoint;
			}
			print ' ';
			print_cpinfo $codepoint;
		}
		print "\n"
	}
	print "\n"
}
