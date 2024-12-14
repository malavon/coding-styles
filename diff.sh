#!/bin/sh

STYLE_TO_TEST="${1:-"NO STYLE PROVIDED"}"
for STYLE in $(find "${PWD}" -name "*.style" | grep -v "${STYLE_TO_TEST}"); do
	EQUAL=$(comm -12 "${STYLE}" "${PWD}/${STYLE_TO_TEST}" | wc -l)
	FILE="$(basename ${STYLE})"
	(comm -13 "${STYLE}" "${PWD}/${STYLE_TO_TEST}" > "/tmp/${FILE}")
	(comm -23 "${STYLE}" "${PWD}/${STYLE_TO_TEST}" > "/tmp/diff-${FILE}")
	echo "${EQUAL} lines common with ${FILE}. Unique lines outputted to /tmp/${FILE}, differences outputted to /tmp/diff-${FILE}"
done
