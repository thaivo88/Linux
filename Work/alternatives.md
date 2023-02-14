# Alternatives

The alternatives command has many more features, including the ability to symlink dependent components when a specific alternative is chosen. 
In addition to handling a lot of the heavy lifting, alternatives keeps your inconsistencies centralized. You can check in on what alternatives are in place, 
so you don't have to remember from day to day that emacs is actually emacs-26.3, or that java isn't java-1.8 but /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0, 
and so on:

```
alternatives --list
```

# Removing an alternative

Sometimes alternatives are long-term solutions, and other times they're just to help users or admins to transition to something new. 
If you need to remove an alternative for any reason, you can do that with the --remove-all option, followed by the "generic" name of the alternative. 
In this example, that's uemacs:

```
sudo alternatives --remove-all uemacs
```

This removes everything about uemacs from the alternatives subsystem: the symlink in /usr/bin and /etc/alternatives. 
If you only want to remove one choice from an alternative, then use the --remove option, providing the alternative name (uemacs in this example) and the path of the 
choice you want to drop:

```
sudo alternatives --remove uemacs /opt/em-legacy/em2
```

Setting the default python3 to python3.8

```
alternatives --set python3 /usr/bin/python3.8
```
