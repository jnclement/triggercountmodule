for rn in `ls /sphenix/tg/tg01/jets/jocl/trigcount/`; do
    echo $rn
    bash run_add.sh $rn
done
