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
