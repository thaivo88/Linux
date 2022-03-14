Options are characters with a single dash before them.
Check out this example:
```$ ./script1.sh -a```
The *-a* is an option. You can check from your script if the user entered this option; if so,
then your script can behave in some manner.
You can pass multiple options:
```$ ./script1.sh -a -b -c```
To print these options, you can use the *$1, $2, and $3* variables:
```
#!/bin/bash
echo $1
echo $2
echo $3
```
Options can be passed with a value, like this:
```$ ./script1.sh -a -b 20 -c```
Here the *-b* option is passed with a value of *20*.
As you can see, the variable $3=20, which is the passed value. Since *20* is in the 3rd position.
This might not be acceptable to you. You need *$2=-b and $3=-c*.
We will use some conditional statements to get these options correct
```
#!/bin/bash
while [ -n "$1" ]
do
case "$1" in
-a) echo "-a option used" ;;
-b) echo "-b option used" ;;
-c) echo "-c option used" ;;
*) echo "Option $1 not an option" ;;
esac
shift
done
```
The *shift* command shifts the options one step to the left.
So, if we have three options or parameters and we use the shift command:

- $3 becomes $2
- $2 becomes $1
- $1 is dropped

It's like an action to move forward while iterating over the options using the while loop. So, in the first loop cycle, *$1* will be the first option. After shifting the options, *$1* will be the second option and so on.
