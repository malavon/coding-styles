#!/bin/sh
set -x
FORMATTERS=$(ls /usr/local/bin/clang-format*)
for formatter in ${FORMATTERS}; do
	STYLES=$(${formatter} --help | grep -A1 -- --style= | tail -n1 | tr -d ' .' | sed 's/,/ /g' )
	for style in ${STYLES}; do
		BASE=$(basename ${formatter})
		(${formatter} --style=${style} --dump-config > ${BASE}-${style}.style)
	done
done
