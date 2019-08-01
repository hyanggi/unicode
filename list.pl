#!/usr/bin/env perl

use strict;
use warnings;

use open ':locale';
use Unicode::UCD 'charblock';

my $block_pre = '';
for (my $i=0; $i<0x2000; ++$i) {
	my $block = charblock(0x10 * $i);
	if ($block ne $block_pre) {
		print "\n", $block, "\n";
		$block_pre = $block;
	}
	next if ($block eq 'CJK Unified Ideographs');
	next if ($block eq 'CJK Unified Ideographs Extension A');
	next if ($block eq 'Hangul Syllables');

	my $line = '';
	for (my $j=0; $j<0x10; ++$j) {
		my $codepoint = chr 0x10 * $i + $j;
		next if ($codepoint =~ /^\pC$/);
		$line .= '  ';
		$line .= "\x{25cc}" if ($codepoint =~ /^\pM$/);
		$line .= $codepoint;
	}
	printf "%x%s\n", 0x10 * $i, $line unless ($line eq '');
}
