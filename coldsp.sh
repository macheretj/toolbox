#!/bin/sh

NUM_COLS=$1
DATA_FILE=$2

if [[ -z $NUM_COLS || -z $DATA_FILE ]]
then

        echo "WRONG Usage! Please specify number of columns as first arg and data file as 2nd!"
        echo "Example: ./coldsp.sh 4 data.txt"
        exit 10
fi


LENGTH=0
for line in $(cat $DATA_FILE)
do
        TMP_LENGTH=$(echo $line | wc -ck |  tr -d '[[:space:]]')
        if [[ $TMP_LENGTH -gt $LENGTH ]]
        then
                LENGTH=$TMP_LENGTH
        fi
done

LONGEST_STRING=$LENGTH


DATA_LINES_NUM=$(cat $DATA_FILE | wc -l | tr -d '[[:space:]]')

CURR_LINE=$DATA_LINES_NUM
REMAINING_LINES=0

PRINTF_COLS=""

for col in $(seq 1 $NUM_COLS)
do

                PRINTF_COLS="$PRINTF_COLS %-"$LONGEST_STRING"s"
done

until [ $CURR_LINE -lt 0 ]
do

        curr_data=$(cat $DATA_FILE | tail -$CURR_LINE | head -$NUM_COLS)

        printf "$PRINTF_COLS\n" $curr_data
        CURR_LINE=$(expr $CURR_LINE - $NUM_COLS)

done
