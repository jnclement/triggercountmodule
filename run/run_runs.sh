#!/bin/bash

nmax=100
filecounter=0
for rn in `ls  lists/dst_calo_run2pp*.list | awk -F'.' '{print $1}' | awk -F'/' '{print $2}' | awk -F'-' '{print $2}'`; do
    rn=$(expr $rn + 0)
    nfile=`wc -l lists/dst_calo_run2pp-000${rn}.list | awk '{print $1}'`
    njob=$(( $nfile + 9 ))
    njob=$(( $njob / 10 ))
    filecounter=$(( $filecounter + $nfile ))
    if [ $filecounter -gt $nmax ]; then
	break
    fi
    mkdir -p /sphenix/tg/tg01/jets/jocl/evt/$rn
    mkdir -p /sphenix/tg/tg01/jets/jocl/chi2/$rn
    echo $rn $filecounter
    bash run_everything.sh $njob $rn $nfile
done


