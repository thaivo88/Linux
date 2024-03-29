# PBS Job Scheduler

Create pbsdata account  that will never expire: 
```
groupadd  -g 700 -r pbsdata useradd -u 700 -g 700 -m -r -d /usr6/pbsdata -c "PBS Data Service User" -s /bin/bash pbsdata
```

give you a listing of offline nodes
```pbsnodes -l```

Replinish	
First remove comments: leaving comments blank
```
pbsnodes -o  [hostname] -C "" 
pbsnodes -r [hostname]   
```
  	 	 
Offline the node
```
  pbsnodes -o  [hostname] -C "[comment]"
  pbsnodes -o apollon001 -C "hardware maintain"
```

List all node
```pbsnodes -a```
  
check list of jobs then kill job in pbs
```
qstat -an
qdel  <job id> 
```

check frequency queues  
```
qstat -Q
qstat -Q | grep f3 | sort
```

Display queue information:
```
qstat [option]
    -a            Display all jobs in any status (running, queued, held)
    -r            Display all running or suspended jobs
    -n            Display the execution hosts of the running jobs
    -i            Display all queued, held or waiting jobs
    -u username   Display jobs that belong to the specified user
    -s            Display any comment added by the administrator or scheduler. This option is typically used to find clues of why a job has not started running.
    -f job_id     Display detailed information about a specific job
       example: qstat -an
```
