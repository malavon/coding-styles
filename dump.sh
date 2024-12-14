#!/bin/sh
set -x
FORMATTERS=$(ls /usr/bin/clang-format* /usr/local/bin/clang-format*)
for formatter in ${FORMATTERS}; do
	STYLES=$(${formatter} --help | grep -A2 -- "--style=<string>" | sed 's/1. A preset://' | tail -n2 | tr -d ' .' | sed 's/,/ /g' )
	for style in ${STYLES}; do
		echo "STYLE ${style}"
		BASE=$(basename ${formatter})
		(${formatter} --style=${style} --dump-config > ${BASE}-${style}.style)
	done
done
