
# deploy
```
$ rm -r ~/myapp/contactlist01_b4a_functions/contactList01/public/*
$ cp -a /home/catalunha/myapp/contactlist01b4a/build/web/. ~/myapp/contactlist01_b4a_functions/contactList01/public/
$ cd ~/myapp/contactlist01_b4a_functions/contactList01
$ b4a deploy
```


# Created
```
$ flutter create --project-name=contactlist01b4a --org education.brintec --platforms android,web -a kotlin ./contactlist01b4a

```