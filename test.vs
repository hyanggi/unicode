#!/usr/bin/env bash

# This script outputs some strings for testing Unicode variation selectors.
# Font support required to see the differences between variations.

# Mathematical
echo '⊊⊊︀'

# East Asian punctuation positional variants
echo '。。︀。︁'

# CJK compatibility ideographs
# A Japanese font is recommended to see the differences.
echo '艹艹︀艹︁'

# Mongolian
echo ' ‍ᠨ‍  ‍ᠨ᠋‍  ‍ᠨ᠌‍  ‍ᠨ᠍‍ ' # Zero-width-joiner used before and after each letter to select the medial form.

# Emoji
echo '⚽ ⚽︎' # Variation selector 15 (emoji shown as text)
echo '✈ ✈️' # Variation selector 16 (text shown as emoji)
