#!/bin/bash

        outfile="blast_"$DB"_"$BASENAME".tab"

        $BLAST_TYPE -query $INPUTFILE -out $outfile -evalue 0.001 -db $DB -num_threads $THREADS -outfmt 6 -show_gis -max_target_seqs 1

