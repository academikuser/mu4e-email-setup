  dotspacemacs-configuration-layers
   '(
     (mu4e  :variables  
            mu4e-installation-path "/usr/local/Cellar/mu/0.9.18_1/share/emacs/site-lisp"
            mu4e-maildir-shortcuts              t
            mu4e-change-filenames-when-moving   t
            mu4e-view-prefer-html               t
            mu4e-show-images                    t
            mu4e-view-image-max-width         800
            mu4e-enable-async-operations        t
            message-kill-buffer-on-exit         t
            mu4e-enable-mode-line               t
            mu4e-index-cleanup                nil 
            mu4e-index-lazy-check               t
            mu4e-use-fancy-chars                t
            mu4e-enable-notifications           t
            mu4e-html2text-command      "/usr/local/bin/w3m -T text/html"       ;; http://www.ict4g.net/adolfo/notes/2014/12/27/EmacsIMAP.html
            mu4e-get-mail-command       "gtimeout --signal=SIGINT 85 mbsync -Ds March2017"      )

     )

(setq 
gnus-message-archive-method         '(nnimap "imap.gmail.com")
gnus-message-archive-group          "[Gmail]/Sent Mail"
gnus-secondary-select-methods
'(        (nnimap                   "gmail"
                                    (nnimap-addres     "imap.gmail.com")
                                    (nnimap-server-port             993)
                                    (nnimap-stream                  ssl)    ) )
starttls-use-gnutls                 t
message-send-mail-function          'message-send-mail-with-sendmail
send-mail-function                  'message-send-mail-with-sendmail
sendmail-program                    "/usr/local/bin/msmtp"
mail-specify-envelope-from          t
message-sendmail-f-is-evil          nil
mail-envelope-from                  'header
message-sendmail-envelope-from      'header
smtpmail-auth-credentials           (expand-file-name "~/.authinfo.gpg")
smtpmail-stream-type                'tls
smtpmail-smtp-server                "smtp.gmail.com"
smtpmail-smtp-service               465
message-kill-buffer-on-exit         t
) ;; ends a long multi setq

  (setq mu4e-trash-folder
(lambda (msg)
 (cond
      ((mu4e-message-contact-field-matches msg :to
                                                "thomasQ@outlook.com")
                                                                       "/Outlook2/Deleted")
      ((mu4e-message-contact-field-matches msg :to
                                           "anthonyjames@mail.ru")
                                                            "/Russia/&BBoEPgRABDcEOAQ9BDA-")

      ((mu4e-message-contact-field-matches msg :to
                                                 "thomasQ@icloud.com")
                                                                  "/icloud/Deleted Messages")

      ((mu4e-message-contact-field-matches msg :to
                                              "thomasjones@post.bgu.ac.il")
                                                                    "/School/[Gmail]/.Trash")

      ((mu4e-message-contact-field-matches msg :to
                                       "anthonyjames@outlook.com")
                                                                          "/Outlook/Deleted")
      ((mu4e-message-contact-field-matches msg :to
                                              "anthony@anthony.net")
                                                                          "/Outlook/Deleted")
       (t  "/trash"))))

(with-eval-after-load 'mu4e

  (setq starttls-gnutls-program        "/usr/local/bin/gnutls-cli"
        starttls-extra-arguments       nil
        mu4e-compose-in-new-frame      t

        mu4e-contexts
      `( ,(make-mu4e-context
           :name "school"
           :enter-func (lambda () (mu4e-message "Switch to BGU"))
           ;; leave-func not defined
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                             :to "thomasjones@post.bgu.ac.il")))
           :vars '(  ( user-mail-address                       . "thomasjones@post.bgu.ac.il"  )
                     ( user-full-name                          . "Anthony James" )
                     (mu4e-trash-folder                       . "/School/[Gmail].Trash")
                     (mu4e-drafts-folder                       . "/School/[Gmail].Drafts")
                     ;;( mu4e-sent-folder                        . "saved on gmail")
                     ( mu4e-compose-signature .
                                              (concat
                                               "Anthony James\n"
                                               "ShyTown, IL\n"))))
      ,(make-mu4e-context
           :name "Yandex"
           :enter-func (lambda () (mu4e-message "yandex"))
           ;; leave-fun not defined
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :from-or-to "thomasQ@yandex.com")))
           :vars '(  ( user-mail-address            . "thomasQ@yandex.com" )
                     ;;( user-full-name     . "Anthony James" )
                     (mu4e-archive-folder           . "/Yandex/Drafts")
                     (user-full-name                . "thomasQ" )
                     (user                          . "thomasQ")
                     (mu4e-trash-folder             . "/Yandex/Trash")
                     (mu4e-sent-folder              . "/Yandex/Sent")
                     (mu4e-drafts-folder            . "/Yandex/Drafts")
                 ;;  use the .mbsyncrc settings, don't rewrite here
                     (starttls-use-gnutls           . t)
                     (smtpmail-smtp-service         . 465)
                     (smtpmail-smtp-user            . "thomasQ")
                     (smtpmail-starttls-credentials . '(("smtp.yandex.com" 465 nil nil)))
                     (smtpmail-auth-credentials     . '(("smtp.yandex.com" 465 "thomasQ@yandex.com" nil)))
                     (smtpmail-default-smtp-server  . "smtp.yandex.com")
                     (smtpmail-smtp-server          . "smtp.yandex.com")
                     ( mu4e-compose-signature .
                                              (concat
                                               "thomasQ \n"
                                               " Спасибо!\n"
                                               " - п"))))
         ,(make-mu4e-context
           :name "Russia"
           :enter-func (lambda () (mu4e-message "in Russia now"))
           ;; leave-fun not defined
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :from-or-to "anthonyjames@mail.ru")))
           :vars '(  ( user-mail-address            . "anthonyjames@mail.ru" )
                     ;;( user-full-name     . "Anthony James" )
                     (mu4e-archive-folder           . "/Russia/&BBAEQARFBDgEMg-")
                     (user-full-name                . "Бенджамин" )
                     (mu4e-trash-folder             . "/Russia/&BBoEPgRABDcEOAQ9BDA-")
                     (mu4e-sent-folder              . "/Russia/&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-")
                     (mu4e-drafts-folder            . "/Russia/Drafts")
                 ;;  use the .mbsyncrc settings, don't rewrite here
                     (starttls-use-gnutls           . t)
                     (smtpmail-smtp-service         . 465)
                     (smtpmail-smtp-user            . "anthonyjames@mail.ru")
                     (smtpmail-starttls-credentials . '(("smtp.mail.ru" 465 nil nil)))
                     (smtpmail-auth-credentials     . '(("smtp.mail.ru" 465 "anthonyjames@mail.ru" nil)))
                     (smtpmail-default-smtp-server  . "smtp.mail.ru")
                     (smtpmail-smtp-server          . "smtp.mail.ru")
                     ( mu4e-compose-signature .
                                              (concat
                                               "Anthony James\n"
                                               " Спасибо!\n"
                                               " - Бенджамин"))))
         ,(make-mu4e-context
           :name "personal"
           :enter-func (lambda () (mu4e-message "thomasQ Gmail"))
           ;; leave-fun not defined
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :from-or-to "thomasQ@gmail.com")))
           :vars '(  ( user-mail-address  . "thomasQ@gmail.com" )
                     ( user-full-name     . "Anthony James" )
                     (mu4e-trash-folder   .  "/Trash")
                     (starttls-use-gnutls           . t)
                     (smtpmail-smtp-service         . 587)
                     (user                          . "thomasQ")
                     (smtpmail-starttls-credentials . '(("smtp.gmail.com" 587 nil nil)))
                     (smtpmail-auth-credentials     . '(("smtp.gmail.com" 587 "thomasQ@gmail.com" nil)))
                     (smtpmail-smtp-server          . "smtp.gmail.com")
                     (smtpmail-default-smtp-server  . "smtp.gmail.com")
                     (smtpmail-smtp-user            . "thomasQ@gmail.com")
                     ( mu4e-compose-signature .
                                              (concat
                                               "Anthony James\n"
                                               "@ . . . \n"))))
  ,(make-mu4e-context
           :name "m$ft"
           :enter-func (lambda () (mu4e-message "thomasQ outlook"))
           ;; leave-fun not defined
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :from-or-to "thomasQ@outlook.com")))
           :vars '(  ( user-mail-address                         . "thomasQ@outlook.com" )
                     ( user-full-name                            . "Anthony James" )
                     (mu4e-trash-folder                          .  "/Outlook2/Deleted")
                     (mu4e-drafts-folder       .                    "/Outlook2/Drafts")
                     (mu4e-follow-up-folder    .                    "/Outlook2/FollowUp")
                     (mu4e-hold-folder         .                    "/Outlook2/Hold")
                     (mu4e-refile-folder       .                    "/Outlook2/Archive")
                     (mu4e-sent-folder         .                    "/Outlook2/Sent")
                     (starttls-use-gnutls           . t)
                     (smtpmail-smtp-user            . "thomasQ@outlook.com")
                     (smtpmail-starttls-credentials . '(("smtp-mail.outlook.com" 587 nil nil)))
                     (smtpmail-auth-credentials     . '(("smtp-mail.outlook.com" 587 "thomasQ@outlook.com" nil)))
                    ;; (smtpmail-default-smtp-server  . "smtp-mail.outlook.com")
                     (smtpmail-smtp-server          . "smtp-mail.outlook.com")
                     ( mu4e-compose-signature .
                                              (concat
                                               "Anthony James\n"
                                               "@outlook.com\n"))))
  ,(make-mu4e-context
           :name "anthony"
           :enter-func (lambda () (mu4e-message "anthony outlook"))
           ;; leave-fun not defined
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :from-or-to "anthonyjames@outlook.com")))
           :vars '(  ( user-mail-address                         . "anthonyjames@outlook.com" )
                     ( user-full-name                            . "Anthony James" )
                     (mu4e-trash-folder                          .  "/Outlook/Deleted")
                     (mu4e-drafts-folder       .                    "/Outlook/Drafts")
                     (mu4e-follow-up-folder    .                    "/Outlook/FollowUp")
                     (mu4e-hold-folder         .                    "/Outlook/Hold")
                     (mu4e-refile-folder       .                    "/Outlook/Archive")
                     (mu4e-sent-folder         .                    "/Outlook/Sent")
                     (starttls-use-gnutls           . t)
                     (smtpmail-smtp-user            . "anthonyjames@outlook.com")
                     (smtpmail-starttls-credentials . '(("smtp-mail.outlook.com" 587 nil nil)))
                     (smtpmail-auth-credentials     . '(("smtp-mail.outlook.com" 587 "anthonyjames@outlook.com" nil)))
                    ;; (smtpmail-default-smtp-server  . "smtp-mail.outlook.com")
                     (smtpmail-smtp-server          . "smtp-mail.outlook.com")
                     ( mu4e-compose-signature .
                                              (concat
                                               "Anthony James\n"
                                               "@outlook.com\n"))))
 ,(make-mu4e-context
           :name "ou"
           :enter-func (lambda () (mu4e-message "ohiostate.net"))
           ;; leave-fun not defined
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :from-or-to "tonySmith@ohiostate.net")))
           :vars '(  ( user-mail-address       .                   "tonySmith@ohiostate.net" )
                     ( user-full-name          .                   "Anthony James" )
                     (mu4e-trash-folder        .                    "/ou/Deleted")
                     (mu4e-drafts-folder       .                    "/ou/Drafts")
                     (mu4e-follow-up-folder    .                    "/ou/FollowUp")
                     (mu4e-hold-folder         .                    "/ou/Hold")
                     (mu4e-refile-folder       .                    "/ou/Archive")
                     (mu4e-sent-folder         .                    "/ou/Sent")
                     (starttls-use-gnutls           . t)
               ;;      (smtpmail-smtp-user            . "tonySmith@ohiostate.net")
                     (smtpmail-starttls-credentials . '(("smtp.office365.com" 587 nil nil)))
                     (smtpmail-auth-credentials     . '(("smtp.office365.com" 587 "tonySmith" nil)))
               ;;      (smtpmail-default-smtp-server  . "smtp.office365.com")
                     (smtpmail-smtp-server          . "smtp.office365.com")
                     ( mu4e-compose-signature .
                                              (concat
                                               "Anthony James\n"
                                               "\n"))))

         ))

  '(setq mu4e-compose-context-policy ask)
  mu4e-user-mail-address-list
  (delq nil
        (mapcar (lambda (context)
                  (when (mu4e-context-vars context)
                    (cdr (assq 'user-mail-address (mu4e-context-vars context)))))
                mu4e-contexts))

  ) 

