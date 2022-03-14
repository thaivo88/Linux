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



***Read Prompts***

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


**Read -n**

We have not needed this functionality in the scripts we have used so far, but we may need to ask users to hit any key to continue. At the moment, we have set it up in such a way that the variable is not populated until we hit the <i>Enter</i> key. Users have to hit <i>Enter</i> to continue. If we use the <i>-n</i> option followed by an integer, we can specify the number of characters to accept before continuing; we will set 1 in this case. Take a look at the following code extract:
```
#!/bin/bash
read -p "May I ask your name: " name
echo "Hello $name"
read -n1 -p "Press any key to exit"
echo
exit 0
```
Now the script will pause after displaying the name until we press any key; we can literally press any key before continuing, as we accept just 1 key stroke, whereas earlier we were required to leave the default behavior in place, as we could not know how long an entered name would be. We have to wait for the user to hit Enter. 

**Controlling Visibility of the entered text**

In the same way, if we type the name, we get to see the entered text before we hit Enter. In this case, it is just untidy, but if we are entering sensitive data, such as a PIN or a password, we should hide the text. We can use the silent option, or *-s*, to achieve this. A simple edit in the script will set this in place: 
```
#!/bin/bash
read -p "May I ask your name: " name
echo "Hello $name"
read -sn1 -p "Press any key to exit"
echo
exit 0
```

![image](https://user-images.githubusercontent.com/15881158/158228342-70fcf720-d76b-4bff-801a-7a69506f4b82.png)
