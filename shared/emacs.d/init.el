;;; init.el -- My Emacs configuration
;;-*-Emacs-Lisp-*-

;;; Commentary:
;;
;; I have nothing substantial to say here.
;;
;;; Code:

;; (package-initialize)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (hydra multi-term neotree buffer-move form-feed git-gutter-fringe linum-relative adaptive-wrap rainbow-mode yasnippet org-plus-contrib markdown-mode web-mode flycheck-gometalinter go-rename company-go go-mode company-tern js2-mode helm-swoop helm-ag helm-projectile powerline-evil key-chord evil-numbers evil-matchit evil-org evil-leader evil-visualstar evil-escape evil-search-highlight-persist evil-surround evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
