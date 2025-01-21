#!/bin/sh
# 
# Version       : 1.3
# Date          : 2021.01.30
# Author        : Minseop Kim (Ghayoun I&C)
# Applies To    : Control-M/Server 8.0.00 / 9.0.00 / 9.0.18 / 9.0.20
# Output Format : JOBNAME,DATE
# History       :
#    v1.2 - fixed blank or korean in jobname
#    v1.3 - fixed empty folder

NUMB=0
COUNTDAYS=31

CTMRPLN_DIR=$HOME/EZJOBS/CTMRPLN
DATA_DIR=$CTMRPLN_DIR/DATA
TMP_DIR=$CTMRPLN_DIR/TMP

# getting architecture
machine=`uname`
if [ $machine = "Linux" ] ; then
   LC_CTYPE=ko_KR.utf8
elif [ $machine = "SunOS" ] ; then
   LC_CTYPE=ko.UTF-8
else
   LC_CTYPE=KO_KR.UTF-8
fi
export LC_CTYPE
#

if [ ! -d $DATA_DIR ]; then
   mkdir -p $DATA_DIR
fi

if [ ! -d $TMP_DIR ]; then
   mkdir -p $TMP_DIR
fi

if [ ! `ls $DATA_DIR | wc -l` == 0 ]; then
   rm $DATA_DIR/*
fi

# Get th DATES
for ((i=0; i<$COUNTDAYS; i++));
do
   Date=`perl -e '@T=localtime(time+'$NUMB');printf("%04d%02d%02d",$T[5]+1900,$T[4]+1,$T[3])'`
   NUMB=`expr $NUMB + 86400`
   DATES=$DATES" "$Date
done

# Automatic Order Folder List 
FOLDERS=`ctmpsm -FOLDER -LISTFOLDER "*"|awk '{if ($3=="SYSTEM") print $2}'`

for ONEDAY in $DATES
do
   echo $ONEDAY" DAY JOB PLAN LIST"
   for FOLDER in $FOLDERS
   do
      printf " Working Forder [ %-50s ] ........... " $FOLDER
      # Creating a report when the jobs are scheduled to run
      ctmrpln DJ Y $FOLDER "*" $ONEDAY > $TMP_DIR/$FOLDER_$ONEDAY
	  rc=$?
      if [ $rc -eq 0 ] ; then
	     cat $TMP_DIR/$FOLDER_$ONEDAY | sed '1,9d' | cut -b1-64 | sed -e 's/^ *//' -e 's/ *$//' -e "s/$/,${ONEDAY}/g" >> $DATA_DIR/$ONEDAY
         echo "Completed"
      else
	  echo "No job definitions found"
      fi
   done
   cat $DATA_DIR/$ONEDAY >> $DATA_DIR/ctmrpln.dat
done

#cat ${DATA_DIR}/ctmrpln.dat
