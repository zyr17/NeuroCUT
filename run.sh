if [[ $# -eq 0 ]] ; then
    TRAIN="test_rw"
    echo "No arguments supplied, using default: $TRAIN"
    exit
else
    TRAIN="$1"
fi
TRAIN=${TRAIN##data/}
TRAIN_LOG=`echo $TRAIN | sed 's/\//_/g'`
echo "Running $TRAIN" "saving to logs/$TRAIN_LOG.txt"
make main train=$TRAIN cuttype="normalised" initial_type=metis modelScore=ModelLocalLinkPred gpu=0 epochs=10 node_select=true node_select_heuristic="diff_max_balanced" embedding="given" hops=2 wandb=false 2>&1 | tee logs/$TRAIN_LOG.txt