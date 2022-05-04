```
journalctl -u postfix | grep -i [username]
May 04 09:09:40 hpcgate postfix/smtp[1583]: CE7D7C9922C: to=<pablo.donis@hpe.com>, orig_to=<pdonis>, relay=none, delay=0.12, delays=0/0.01/0.11/0, dsn=4.4.1, status=deferred (connect to smtp1.hpe.com[15.241.140.78]:25: No route to host)
```
```
postcat -vq [message_code]
postcat -vq CE7D7C9922C
```
