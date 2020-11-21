# SSH auth via GPG subkey

Remember to add gpg subkeys to the `sshcontrol` file.

```bash
$ gpg -K --with-keygrip
$ echo MYAUTHKEYGRIP >> sshcontrol
```
