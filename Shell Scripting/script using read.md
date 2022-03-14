$HOME/bin/hello3.sh script so that it reads as follows:
```
#!/bin/bash
echo -n "Hello $(basename $0)! May I ask your name: "
read
echo "Hello $REPLY"
exit 0
```

As we execute the script, we will be greeted and prompted with whatever is typed. This is echoed using the <i>$REPLY</i> variable in the echo statement. As we have not yet supplied a variable name to the read built-in command, the default <i>$REPLY</i> variable is used.

![image](https://user-images.githubusercontent.com/15881158/158221943-4e62c9d3-6f80-4913-8575-0270391922cc.png)

You can set a variable for the user's input by naming a variable after the <i>read</i> command
In the case below we name the variable yn when the script ask the user's input for y/n
```
grep -R -i passwd /var/log/* | grep $1

 echo Was there a successful password update log?
 echo y/n:

read yn

if [ $yn = y ];
  then
    chage -d $(date +%F) $1
        passwd -u $1
                echo Aging password has been reset
else
echo no changes
fi
```

The read command with syntax using the -p option is shown as follows:
```
read -p <prompt> <variable name>
```
We can edit the script so that it appears similar to the following extract from hello3.sh:
```
#!/bin/bash
read -p "May I ask your name: " name
echo "Hello $name"
exit 0
```
The read prompt cannot evaluate commands within the message string, such as those we used before.
