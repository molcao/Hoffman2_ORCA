###########################################
### THIS SCRIPT WAS WRITTEN BY NATOOOH  ###               
###      edited by molcao 250304        ###
###########################################
#!/bin/bash
#$ -cwd
# error = Merged with joblog
#$ -o joblog.$JOB_ID
#$ -j y
# Email address to notify
#$ -M $USER@mail
# Notify when
#$ -m bea


# Find input file and set it as jobname
for file in *; do
  if [ -f "$file" ]; then
    extension="${file##*.}"
    if [ "$extension" == "inp" ]; then
      file_name=$(basename "$file" ."$extension")
      echo "$file_name"
    fi
  fi
done

export jobname=$file_name

# echo job info on joblog:
echo "Job $JOB_ID started on:   " `hostname -s`
echo "Job $JOB_ID started on:   " `date `
echo "Job $JOB_ID will run on:i "
cat $PE_HOSTFILE
echo " "

# load the job environment:
. /u/local/Modules/default/init/modules.sh
module load orca/6.0.0
module li

# create and move input files to $SCRATCH
mkdir $SCRATCH/$JOB_ID
echo $SCRATCH/$JOB_ID
ls -latr $SCRATCH/$JOB_ID
if [ -e $file_name.inp ]; then
 echo "cp $file_name.inp $SCRATCH/$JOB_ID"
 cp $file_name.* $SCRATCH/$JOB_ID
else
 echo -e "\n No input file detected. Please submit this scrip with:"
 echo -e "\n \t qsub -N jobname submit_orca.sh\n"
 echo -e "where: \"jobname\" is the name of the input file"
 echo -e "without the \".inp\" extension.\n"
 exit
fi

#Go to scratch folder and run Orca. If it fails uncomment the module load
cd $SCRATCH/$JOB_ID
#module load orca/6.0.0
pwd

# run Orca
echo '/usr/bin/time -v $ORCA_DIR/orca ./$file_name.inp >> $SGE_O_WORKDIR/$file_name.$JOB_ID.out'
/usr/bin/time -v $ORCA_DIR/orca ./$file_name.inp >> $SGE_O_WORKDIR/$file_name.$JOB_ID.out

# copy output back. This might be unnecessary but leaving it on anyways. It should copy all files back that arent .temp files
list=`ls -1 | grep -v .tmp`
#list=`ls -l *.out *.hess`
for i in $list; do
 pwd
 echo "cp -p $i $SGE_O_WORKDIR"
 cp -p $i $SGE_O_WORKDIR
done

#reload the input folder
ls
cd $SGE_O_WORKDIR
pwd

#destroy the scratch directory
#echo "rm -rf $SCRATCH/$JOB_ID"
#rm -rf $SCRATCH/$JOB_ID

