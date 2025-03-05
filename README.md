# Hoffman2_ORCA

## Requirements:<br/>
-FTP software<br/>
-any sort of terminal for non-interactive use<br/>

## Logging in:<br/>
-Run command in terminal:<br/>
>	$ ssh [username]@hoffman2.idre.ucla.edu<br/>

For file transfers, use host [username]@dtn.hoffman2.idre.ucla.edu

## Installation:<br/>
-Copy (FTP Software) the contents of bash.txt into your ~/.bashrc<br/>
-Copy files from bin to ~/.local/bin/<br/>
-While logged in via terminal, run shell commands IN ORDER:<br/>
>	$ cd ~/.local<br/>
>	$ find . -type f -print0 | xargs -0 dos2unix<br/>
>	$ chmod -R 770<br/>

## Instructions for using these commands:<br/>
-NEVER have more than 1 *.inp in a directory<br/>
-in the desired directory, run a submission command (see table below)<br/>
-a [filename].[jobnumber].out file will appear once it has started running<br/>
-once the calculation is done, the contents of the scratch directory will be copied to the directory the job was started from. <br/>
-use a file transfer software to transfer the files to a local directory<br/>

In each Orca (Orca v6.0.0) job, you should have the following two commands:<br/>
>	%pal<br/>
>	 nprocs N<br/>
>	end<br/>
>	maxcore X<br/>

Where N is the number of processors and X is the amount of memory allotted to each processor in MB. It should match the Orca submission command that you intend to submit. Nprocs and maxcore settings in the your orca submission script should match the nprocs and maxcore settings from the command. 

Recommended nprocs and maxcore settings
> [!NOTE]
> Nodes available as of 231207<br/>
> Nodes avail is the absolute max possible<br/>
> Parts of the scripts make the real number smaller<br/>


| 	command 	| 	nprocs | 	maxcore 	| 	nodes avail 	|
| --------------------- | -------------| ----------------------| ---------------|
| 	osubS   	|   	8    |  	2000   	|    	791      	|
| 	osub    	|   	16   |  	2000   	|    	791      	|
| 	osubL   	|   	24   |  	5000   	|    	538      	|
| 	osubXL  	|   	36   |  	5000   	|    	440      	|
| 	osubXXL 	|   	48   |  	5000   	|    	70       	|


## Other useful commands included:
>	$ osubL_all

> [!CAUTION]
> Only use osubL_all if you mean it! <br/>
> runs osubL recursively through all directories that contain a .inp within the current directory

>	$ dus

calculates the size of all directories in your $SCRATCH

>	$ duh    

calculates the size of all directories in $HOME

>	$ qs

lists all of your queued and running jobs

## Other useful general commands:

> 	$ qdel -u [username]

kills all of your submitted jobs. Especially good if you accidentally run osubL_all somewhere :)

>	$ qdel [jobnumber]

kills specific job number


## Other useful information:

Your $HOME directory has a quota of 60 GB (hard limit)

Your $SCRATCH directory has a quota of 2 TB (hard limit)

