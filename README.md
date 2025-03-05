# Hoffman2_ORCA

Requirements:
-FTP software
-any sort of terminal for non-interactive use

Logging in:
-Run command in terminal:
	$ ssh [username]@hoffman2.idre.ucla.edu

For file transfers, use host [username]@dtn.hoffman2.idre.ucla.edu

Installation:
-Copy (FTP Software) the contents of bash.txt into your ~/.bashrc
-Copy files from bin to ~/.local/bin/
-While logged in via terminal, run shell commands IN ORDER:
	$ cd ~/.local
	$ find . -type f -print0 | xargs -0 dos2unix
	$ chmod -R 770

Instructions for using these commands:
-NEVER have more than 1 *.inp in a directory
-in the desired directory, run a submission command (see table below)
-a [filename].[jobnumber].out file will appear once it has started running
-once the calculation is done, the contents of the scratch directory will be copied to the directory the job was started from. 
-use a file transfer software to transfer the files to a local directory

In each Orca (Orca v6.0.0) job, you should have the following two commands:
	%pal
	 nprocs N
	end
	maxcore X
Where N is the number of processors and X is the amount of memory allotted to each processor in MB. It should match the Orca submission command that you intend to submit. Nprocs and maxcore settings in the your orca submission script should match the nprocs and maxcore settings from the command. 

Recommended nprocs and maxcore settings
(nodes avail as of 231207
   nodes avail is the absolute max possible
        parts of the scripts make the real number smaller)
--------------------------------------------
| command | nprocs | maxcore | nodes avail |
--------------------------------------------
| osubS   |   8    |  2000   |    791      |
| osub    |   16   |  2000   |    791      |
| osubL   |   24   |  5000   |    538      |
| osubXL  |   36   |  5000   |    440      |
| osubXXL |   48   |  5000   |    70       |
--------------------------------------------

Other useful commands included:
	osubL_all	runs osubL recursively through all directories that contain a .inp within the current directory
	dus    calculates the size of all directories in your $SCRATCH
	duh    calculates the size of all directories in $HOME
	qs     lists all of your queued and running jobs

Other useful general commands:
	qdel -u [username] kills all of your submitted jobs. Especially good if you accidentally run osubL_all somewhere :)
	qdel [jobnumber] kills specific job number

Other useful information:
Your $HOME directory has a quota of 60 GB (hard limit)
Your $SCRATCH directory has a quota of 2 TB (hard limit)
