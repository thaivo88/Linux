**Passing Options**
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


**Passing parameters with options**

Using the previous technique, we can iterate over the options till we reach the double dash,
then we will iterate over the parameters:
```
#!/bin/bash
while [ -n "$1" ]
do
case "$1" in
-a) echo "-a option found" ;;
-b) echo "-b option found";;
-c) echo "-c option found" ;;
--) shift
break ;;
*) echo "Option $1 not an option";;
esac
shift
done
#iteration over options is finished here.
#iteration over parameters started.
num=1
for param in $@
do
echo "#$num: $param"
num=$(( $num + 1 ))
done
```
Now if we run it with parameters and options combined, we should see a list of options and
another list of parameters:
$ ./script1.sh -a -b -c -- p1 p2 p3

![image](https://user-images.githubusercontent.com/15881158/158231409-821bc098-e3b2-4056-a9db-6cdbabb7cc21.png)

**Read options values**

We have seen how to identify options and parameters, but we still need a way to read the options values correctly.
You may need to pass a value for a specific option. How can this value be read?
We will check for the *$2* variable while the iteration goes through the options that we expect a value for.
Check the following code:
```
#!/bin/bash
while [ -n "$1" ]
do
case "$1" in
-a) echo "-a option passed";;
-b) param="$2"
echo "-b option passed, with value $param"
shift ;;
-c) echo "-c option passed";;
--) shift
break ;;
*) echo "Option $1 not an option";;
esac
shift
done
num=1
for param in "$@"
do
echo "#$num: $param"
num=$(( $num + 1 ))
done
```

![image](https://user-images.githubusercontent.com/15881158/158235163-6f986124-44b9-4a40-8adb-910ad25eca72.png)

This looks good now; your script identifies the options and the passed value for the second option.
There is a built-in option for getting options from the users, which is using the *getopt* function.
Unfortunately, getopt doesn't support options with more than one character.
There is a non-built-in program called *getopt*, which supports options larger than one
character, but, again, the macOS X version doesn't support long options.


**Standard**

These are some of the commonly used options:
- -a: List all items
- -c: Get a count of all items
- -d: Output directory
- -e: Expand items
- -f: Specify a file
- -h: Show the help page
- -i: Ignore the character case
- -l: List a text
- -o: Send output to a file
- -q: Keep silent; don't ask the user
- -r: Process something recursively
- -s: Use stealth mode
- -v: Use verbose mode
- -x: Specify an executable
- -y: Accept without prompting me
