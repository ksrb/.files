;;; init-elpa.el -- My Emacs configuration
;;-*-Emacs-Lisp-*-

;;; Commentary:
;;
;; I have nothing substantial to say here.
;;
;;; Code:

(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(cond
 ((equal system-type 'cygwin)
  (setq package-user-dir "~/.emacs.d/elpa-cygwin")
  )
 )

(package-initialize)

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 (list 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(provide 'init-elpa)
;;; init-elpa.el ends here
