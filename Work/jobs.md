# Jobs

to run jobs add & after the command to run in the background
example: 
```dnf update &```

to list all the jobs
```jobs -l```

to list all the stop jobs aka paused
```jobs -s```

to kill/stop the job
```kill %[the_job_number]```
  
  
  Option	Description
```
-l	Show process id’s in addition to the normal information.
-p	Show process id’s only.
-n	Show only processes that have changed status since the last notification are printed.
-r	Restrict output to running jobs only.
-s	Restrict output to stopped jobs only.
-x	COMMAND is run after all job specifications that appear in ARGS have been replaced with the process ID 
of that job’s process group leader.
```
