#!/bin/bash

echo "Enter name of template manifest:"
read template
echo "Enter prefix for output manifests:"
read prefix
echo "Enter number of manifests to generate minus one (e.g. lab of 40 requires 39 due to using 01 as the template):"
read max

suffix=MD
if [ $max -gt 1 ]; then
	if [ $max -lt 10 ]; then
		for n in $(eval echo {2..$max}); do cp $template $prefix"0"$n$suffix; done
	else	
		for n in {2..9}; do cp $template $prefix"0"$n$suffix; done
		for n in $(eval echo {10..$max}); do cp $template $prefix$n$suffix; done
	fi
else
	echo "number of manifests must be greater than 1. please re-run script"
fi
