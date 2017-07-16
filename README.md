# mu4e-email-setup

- [more documentation of mu4e - contexts](#sec-1)
  - [init.el](#sec-1-1)
  - [~/.msmtprc](#sec-1-2)
  - [~/.mbsyncrc   - the config file for isync](#sec-1-3)
  - [testing](#sec-1-4)
    - [chmod +x /usr/local/bin/testemail](#sec-1-4-1)
    - [testemail](#sec-1-4-2)

# more documentation of mu4e - contexts<a id="sec-1"></a>

A complete working setup for mu4e is split among at least 3 config files, the emacs config, the getting new mail, and the sending mail.  Here I get mail with the isync package, I prefer it to offlineIMAP.

sending is msmtprc  
receiving is mbsyncrc   
emacs is init.el or .spacemacs (user-config)   
testing is /usr/local/bin/testemail  


.

