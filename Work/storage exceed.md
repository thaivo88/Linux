Get to the root of your machine by running cd /
Run 
```
sudo du -h --max-depth=1
```
Note which directories are using a lot of disk space.
cd into one of the big directories.
Run ls -l to see which files are using a lot of space. Delete any you don’t need.
Repeat steps 2 to 5.


directories taking the most space
```
du -Sh | sort -rh | head -5
du -h | sort -rh | head -10
```

```
find . -maxdepth 1 -type d |xargs -idname sudo du -sh dname
or 
find . -maxdepth 1 -type d -exec sudo du -sh {} \; > FindOutput.$$ ; \
  for Size in T G M K '[^TGMK]'; do grep -E '^[0-9\.]+'"${Size}[[:space:]]" FindOutput.$$| sort -r -g; done; \
  rm -f FindOutput.$$
```

![image](https://user-images.githubusercontent.com/15881158/194588753-343ea63e-2261-4604-87be-57178c31468b.png)
