To declare an array, just enclose its elements between brackets, like this:
```
#!/bin/bash
myarr=(one two three four five)
```

To access a specific array element, you can specify its index like this:
```
#!/bin/bash
myarr=(one two three four five)
echo ${myarr[1]} #prints two which is the second element
```

The index is zero based.
To print the array elements, you can use an asterisk, like this:
```
#!/bin/bash
myarr=(one two three four five)
echo ${myarr[*]}
```

To remove a specific element from the array, you can use the unset command:
```
#!/bin/bash
myarr=(one two three four five)
unset myarr[1] #This will remove the second element
unset myarr #This will remove all elements
```
