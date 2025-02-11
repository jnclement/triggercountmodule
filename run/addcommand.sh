#!/bin/bash                                                                                                            
# file name: firstcondor.sh                                                                                            

source /opt/sphenix/core/bin/sphenix_setup.sh -n ana.458
source /opt/sphenix/core/bin/setup_local.sh "/sphenix/user/jocl/projects/testinstall"
export HOME=/sphenix/u/jocl
export TESTINSTALL=/sphenix/user/jocl/projects/testinstall
echo $LD_LIBRARY_PATH
echo $PATH
if [[ ! -z "$_CONDOR_SCRATCH_DIR" && -d $_CONDOR_SCRATCH_DIR ]]; then
    cd $_CONDOR_SCRATCH_DIR
else
    echo condor scratch NOT set
    exit -1
fi

mkdir srces

for file in `ls /sphenix/tg/tg01/jets/jocl/trigcount/${1}/*`; do
    cp $file ./srces
done

nfile=`ls srces | wc -l`
cp /sphenix/user/jocl/projects/triggercountmodule/run/analyze.C .
root -b -q "analyze.C(${1},${nfile})"

cp triggeroutput_$1.root /sphenix/user/jocl/projects/triggercountmodule/run/output/added/
