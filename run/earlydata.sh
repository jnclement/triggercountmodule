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
SUBDIR=${1}
STARTN=$(( $1 * 10 ))
for i in {1..10}; do
    UPLN=$(( $STARTN + $i ))
    mkdir -p trigout
    mkdir -p $SUBDIR
    mkdir -p lists
    mkdir -p /sphenix/tg/tg01/jets/jocl/trigcount/${2}/
    mkdir -p ./dsts/$2/${2}_${UPLN}
    cp -r /sphenix/user/jocl/projects/triggercountmodule/run/run_earlydata.C .
    cp -r /sphenix/user/jocl/projects/triggercountmodule/run/lists/dst_calo_run2pp-000${2}.list ./lists/${2}.list
    DSTFILE=`sed -n "${UPLN}"p "./lists/${2}.list"`
    if [ -z "${DSTFILE}" ]; then
	exit 0
    fi
    FULLPATH=`psql FileCatalog -t -c "select full_file_path from files where lfn = '${DSTFILE}';"`
    echo $FULLPATH
    cp $FULLPATH ./$DSTFILE
    ls -larth
    mv $DSTFILE ./dsts/$2/${2}_${UPLN}.root
    root -b -q 'run_earlydata.C('${UPLN}',0,'${2}','${3}')'
    cp trigout/* /sphenix/tg/tg01/jets/jocl/trigcount/${2}/
done
