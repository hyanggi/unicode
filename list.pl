#!/usr/bin/env perl

use strict;
use warnings;

use open ':locale';
use Unicode::UCD 'prop_invmap';

my ($block_begins, $block_names, $format, $default) = prop_invmap('Block');

for (my $i = 0; $i < @$block_names - 1; ++$i) {
	print "\n";
	my $block = $block_names->[$i];
	print $block, "\n";

	next if ($block eq 'No_Block');
	next if ($block =~ /Surrogates$/);
	next if ($block =~ /Private Use Area/);

	next if ($block =~ /^CJK Unified Ideographs/);
	next if ($block =~ /^CJK Compatibility Ideographs/);
	next if ($block eq 'Hangul Syllables');
	next if ($block =~ /^Tangut/);

	for (my $j = $block_begins->[$i]; $j < $block_begins->[$i + 1]; $j += 0x10) {
		my $line = '';
		for (my $k = 0; $k < 0x10; ++$k) {
			my $codepoint = chr $j + $k;
			next if ($codepoint =~ /^\pC$/);
			$line .= '  ';
			$line .= "\x{25cc}" if ($codepoint =~ /^\pM$/);
			$line .= $codepoint;
		}
		printf "%x%s\n", $j, $line unless ($line eq '');
	}
}
