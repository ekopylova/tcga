#!/bin/bash
# ----------------------------------------------------------------------------
# Copyright (c) 2016--, Evguenia Kopylova.
#
# Distributed under the terms of the Modified BSD License.
#
# The full license is in the file COPYING.txt, distributed with this software.
# ----------------------------------------------------------------------------

#
# Loop over FASTA files in a directory, create single string containing all
# file names and pass to Kraken.
#

search_dir=$1
db_fp=$2
output_dir=$3
threads=$4

input_files_list=""
for dir in $search_dir/*
do
    if [[ -d $dir ]]; then
	for file in $dir/*.fasta
	do
	    if [ "$input_files_list" == "" ]; then
		input_files_list=$file
	    else
		input_files_list=$input_files_list" "$file
	    fi
	done
    fi
done

kraken --preload --db $db_fp --threads $threads --output $output_dir/results_kraken.txt $input_files_list
kraken-mpa-report --db $db_fp $output_dir/results_kraken.txt > $output_dir/${file_out%.*}_kraken.report_mpa
