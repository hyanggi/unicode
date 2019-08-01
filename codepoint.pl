#!/usr/bin/env perl

# This script can be used to detect weird characters in a text file.

use strict;
use warnings;

use utf8;
use open ':locale';
use charnames ':full';

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

	print "\e[36m<", $cpdesc, "\e[36m>\e[0m";
}

while (<>) {
	my @codepoints = split //;
	foreach my $codepoint(@codepoints) {
		if (ord $codepoint >= 0x20 and ord $codepoint < 0x7f) {
			printf '%c', ord $codepoint;
		}
		elsif (ord $codepoint == 0x0a) {
			printf '%c', ord $codepoint;
		}
		elsif ($codepoint =~ /^\p{Block: CJK Unified Ideographs}$/) {
			printf '%c', ord $codepoint;
		}
		elsif ($codepoint =~ /^[◀▶，。]$/) {
			printf '%c', ord $codepoint;
		}
		else {
			print_cpinfo $codepoint;
		}
	}
}
