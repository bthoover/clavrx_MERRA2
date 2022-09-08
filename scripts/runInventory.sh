#!/bin/bash

# Run using screen -dm -S run_for_year /bin/bash runYear.sh <year>
# Ex.) screen -dm -S run_2020 /bin/bash runYear.sh 2020

curr_year=`date +"%Y"`
BASE="$( cd -P "$( dirname "$0" )" && pwd )"
YEAR=${1:-$curr_year}

for i in {1..12}
do
   screen_name=run$YEAR_$i
   /bin/bash $BASE/count_inventory.sh $YEAR $i;err=$?
done