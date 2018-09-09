;;; init.el -- My Emacs configuration
;;-*-Emacs-Lisp-*-

;;; Commentary:
;;
;; I have nothing substantial to say here.
;;
;;; Code:

(require 'init-elpa)
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;; Recursively load forks directory
(let ((default-directory  "~/.emacs.d/forks"))
  (setq load-path
        (append
         (let ((load-path (copy-sequence load-path)))
           (append
            (copy-sequence (normal-top-level-add-to-load-path '(".")))
            (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

;; Settings
(progn
  (load-theme 'base16-eighties-dark t)
  (menu-bar-mode -1)     ;; Remove menu bar
  (tool-bar-mode -1)     ;; Remove tool bar
  (electric-pair-mode t) ;; Automatically complete parens
  (show-paren-mode t)    ;; Show matching paren
  (global-display-line-numbers-mode t)

  (setq backup-directory-alist `(("." . "~/.emacs.d/backups"))           ;; Centeralize for backup directory
        auto-save-file-name-transforms `((".*" "~/.emacs.d/backups/" t)) ;; Centeralize temporary files
        inhibit-startup-message t                                        ;; Disable startup screen
        make-backup-files -1                                             ;; Disable creating of backup files
        default-directory (concat (getenv "HOME") "/")                   ;; Set emacs starting directory to $HOME
        help-window-select t                                             ;; Select help window after prompt
        auto-window-vscroll nil                                          ;; Disable automatic vertical recenter
        scroll-conservatively 100                                        ;; Disable automatic vertical recenter
        mouse-wheel-scroll-amount '(3                                    ;; Scroll 3 rows by default
                                    ((shift) . 5)                        ;; Scroll 5 rows with shift
                                    ((control) . nil))                   ;; Scroll full screen with ctrl
        mouse-wheel-progressive-speed nil                                ;; Remove scroll acceleration
        tab-width 2                                                      ;; Render tabs as 2 spaces
        sh-indentation 2                                                 ;; Use 2 spaces to indent shell scripts
        sh-basic-offset 2                                                ;; Use 2 spaces to indent for all indentation levels
        initial-frame-alist (quote ((fullscreen . maximized)))           ;; Maximize emacs on startup
        display-line-numbers-type 'relative                              ;; Relative line numbering
        )

  (setq-default
   indent-tabs-mode nil ;; Use spaces to indent
   truncate-lines t)    ;; Disable line wrapping

  (add-hook 'text-mode-hook
            '(lambda() (interactive)
               (turn-on-visual-line-mode)
               (setq tab-width 2)))

  (add-hook 'css-mode-hook
            '(lambda() (interactive)
               (setq tab-width 2
                     css-indent-offset 2
                     )))

  (when (display-graphic-p)
    (scroll-bar-mode -1)
    )
  )

;; Bindings
(progn
  (global-set-key [(shift f5)] '(lambda() (interactive) (load-file "~/.emacs.d/lisp/init.el")))
  )

;; Packages
(progn

  (cond
   ((equal system-type 'darwin)
    (set-face-attribute 'default nil :font "-*-Source Code Pro for Powerline-light-normal-normal-*-*-*-*-*-m-0-iso10646-1")

    (use-package exec-path-from-shell
      :config
      (exec-path-from-shell-initialize)
      )
    )
   ((equal system-type 'windows-nt)
    (set-face-attribute 'default nil :font "-outline-Consolas-normal-normal-normal-mono-*-*-*-*-c-*-windows-1258")
    )
   )

  ;; Evil
  (progn
    (use-package evil
      :init
      ;; Visual mode replace see https://github.com/syl20bnr/spacemacs/issues/2032
      (fset 'evil-visual-update-x-selection 'ignore)

      ;; "+p fix see http://stackoverflow.com/questions/26472216/how-to-copy-text-in-emacs-evil-mode-without-overwriting-the-clipboard
      (setq select-enable-clipboard -1)
      :config

      (evil-mode t)
      (setq evil-split-window-below t
            evil-vsplit-window-right t
            evil-want-fine-undo 'fine
            )

      (defun define-evil-fast-window-traversal (key-map)
        "For a KEY-MAP define key bindings that allow for C-h/j/k/l to change buffers"
        (define-key key-map (kbd "C-h") 'evil-window-left)
        (define-key key-map (kbd "C-j") 'evil-window-down)
        (define-key key-map (kbd "C-k") 'evil-window-up)
        (define-key key-map (kbd "C-l") 'evil-window-right))

      (defun jump-to-same-indent (direction)
        (interactive "P")
        (let ((start-indent (current-indentation)))
          (while
              (and (not (bobp))
                   (zerop (forward-line (or direction 1)))
                   (or (= (current-indentation) 0)
                       (> (current-indentation) start-indent)))))
        (back-to-indentation)
        )

      (define-key evil-normal-state-map (kbd "C-{")
        '(lambda () (interactive) (jump-to-same-indent -1)))
      (define-key evil-normal-state-map (kbd "C-}") 'jump-to-same-indent)

      (define-evil-fast-window-traversal evil-normal-state-map)
      (define-evil-fast-window-traversal evil-motion-state-map)

      (define-key evil-normal-state-map (kbd "<wheel-right>")
        (lambda() (interactive) (evil-scroll-column-right 3)))
      (define-key evil-normal-state-map (kbd "<wheel-left>")
        (lambda() (interactive) (evil-scroll-column-left 3)))

      (define-key evil-motion-state-map "$" 'evil-last-non-blank) ;; Stop '$' in visual line mode from selecting newline
      )

    (use-package evil-surround
      :config
      (global-evil-surround-mode)
      )

    (use-package evil-search-highlight-persist
      :config
      (global-evil-search-highlight-persist t)

      ;; Override :noh to hide evil-search-persist-highlight
      (evil-ex-define-cmd "nohlsearch" 'evil-search-highlight-persist-remove-all)
      (evil-ex-define-cmd "noh" 'evil-search-highlight-persist-remove-all)
      )

    (use-package evil-escape
      :config
      (global-set-key (kbd "<escape>") 'evil-escape)
      )

    (use-package evil-visualstar
      :config
      (global-evil-visualstar-mode)
      )

    ;; TODO Remove for hydra?
    (use-package evil-leader
      :config
      (global-evil-leader-mode)
      (evil-leader/set-leader "SPC")
      (evil-leader/set-key "kw" 'delete-trailing-whitespace)
      )

    ;; TODO transfer bindings to remove evil-leader dependency
    (use-package evil-org)

    (use-package evil-matchit
      :config
      (global-evil-matchit-mode 1)
      )

    (use-package evil-numbers
      :config
      (define-key evil-normal-state-map (kbd "C-S-x") 'evil-numbers/dec-at-pt)
      (define-key evil-normal-state-map (kbd "C-S-a") 'evil-numbers/inc-at-pt)
      )

    (use-package evil-commentary
      :config
      (evil-commentary-mode)
      )

    (use-package powerline-evil
      :config
      ;; Custom powerline theme
      (require 'init-powerline)
      (air--powerline-default-theme)
      )
    )

  ;; Helm
  (progn
    (use-package helm-projectile
      :config
      (projectile-mode)
      (helm-projectile-on)
      (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

      (setq projectile-indexing-method 'alien   ;; Use external tools to perform indexing
            projectile-completion-system 'helm  ;; Set projectile to use helm to autocomplete
            helm-display-header-line nil        ;; Hide header with C-j
            helm-mode-fuzzy-match t)

      ;; Use <return> to navigate down a directory in helm-files
      ;; See: http://emacs.stackexchange.com/a/7896
      (defun advice/helm-find-files-navigate-forward (orig-fun &rest args)
        (if (file-directory-p (helm-get-selection))
            (apply orig-fun args)
          (helm-maybe-exit-minibuffer)))

      (advice-add 'helm-execute-persistent-action :around 'advice/helm-find-files-navigate-forward)

      ;; https://github.com/emacs-helm/helm/issues/1100
      (defun my-helm-action-horizontal-split (candidate)
        "Display buffer in horizontal split"
        ;; Select the bottom right window
        (require 'winner)
        ;; Display buffers in new windows
        (dolist (buf (helm-marked-candidates))
          (select-window (split-window-below))
          (if (get-buffer buf)
              (switch-to-buffer buf)
            (find-file buf)))
        (balance-windows))

      (defun my-helm-action-vertical-split (candidate)
        "Display buffer in vertical split"
        ;; Select the bottom right window
        (require 'winner)
        ;; Display buffers in new windows
        (dolist (buf (helm-marked-candidates))
          (select-window (split-window-right))
          (if (get-buffer buf)
              (switch-to-buffer buf)
            (find-file buf)))
        (balance-windows (window-parent)))

      (defun my-helm-horizontal-split ()
        (interactive)
        (with-helm-alive-p
          (helm-exit-and-execute-action 'my-helm-action-horizontal-split)))

      (defun my-helm-vertical-split ()
        (interactive)
        (with-helm-alive-p
          (helm-exit-and-execute-action 'my-helm-action-vertical-split)))

      (global-set-key (kbd "M-x") 'helm-M-x)
      (global-set-key [remap occur] 'helm-occur)
      (define-key global-map [remap find-file] 'helm-find-files)
      (global-set-key [remap list-buffers] 'helm-buffers-list)
      (global-set-key [remap dabbrev-expand] 'helm-dabbrev)
      (define-key evil-normal-state-map (kbd "C-p") 'helm-projectile-find-file)
      (define-key helm-map (kbd "C-j") 'helm-next-line)
      (define-key helm-map (kbd "C-k") 'helm-previous-line)
      (define-key helm-map (kbd "C-b") 'helm-previous-page)
      (define-key helm-map (kbd "C-d") 'helm-next-page)
      (define-key helm-projectile-projects-map (kbd "C-d") 'helm-next-page)             ;; Override opening of directory in dired mode with C-d
      (define-key helm-find-files-map (kbd "<return>") 'helm-execute-persistent-action)
      (define-key helm-projectile-find-file-map (kbd "C-s") 'my-helm-horizontal-split)  ;; Override the grep file action
      (define-key helm-find-files-map (kbd "C-s") 'my-helm-horizontal-split)            ;; Override the grep file action
      (define-key helm-buffer-map (kbd "C-s") 'my-helm-horizontal-split)                ;; Override the grep file action
      (define-key helm-map (kbd "C-v") 'my-helm-vertical-split)
      )

    (use-package helm-ag)

    (use-package helm-swoop)
    )

  ;; JavaScript
  (progn
    (add-to-list 'auto-mode-alist '("\\.eslintrc$" . js-mode))

    (use-package js2-mode
      :config
      (setq js2-basic-offset 2
            js2-strict-trailing-comma-warning nil
            js2-include-node-externs t)

      (evil-define-key 'insert js2-mode-map
        (kbd "<return>") 'js2-line-break ;; Automatically add '*'s to block comments (/**/)
        )

      (define-key js2-mode-map (kbd "M-R") 'tern-rename-variable)

      (add-hook 'js2-mode-hook
                (lambda()
                  (tern-mode t)
                  (yas-activate-extra-mode 'js-mode)
                  ))
      )

    (use-package company-tern
      :config
      (add-to-list 'company-backends 'company-tern)
      (evil-define-key 'normal tern-mode-keymap
        (kbd "<f2>") 'tern-get-docs
        (kbd "<f3>") 'tern-find-definition
        )
      )
    )

  ;; Typescript
  (use-package tide
    :config
    (evil-define-key 'normal tide-mode-map
      (kbd "<f2>") 'tide-documentation-at-point
      (kbd "<f3>") 'tide-jump-to-definition
      (kbd "M-R") 'tide-rename-symbol
      (kbd "M-V") 'tide-refactor
      ;; TODO: add jump location when using <f3> to evil jumplist
      (kbd "M-<left>") 'tide-jump-back
      )
    )

  ;; Golang
  (progn
    (use-package go-mode
      :init
      (setenv "GOPATH" "/Users/ksuen/gocode")
      :config
      (setq gofmt-command "goimports")
      ;; Note that this will cause go-mode to get loaded the first time
      ;; you save any file, kind of defeating the point of autoloading.
      ;; Surfaced from go-mode
      (add-hook 'before-save-hook 'gofmt-before-save)
      (add-hook 'go-mode-hook
                (lambda()
                  (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
                  (setq tab-width 2)))

      (evil-define-key 'normal go-mode-map
        (kbd "<f2>") 'godoc-at-point
        (kbd "<f3>") 'godef-jump)
      )

    (use-package company-go
      :config
      (add-hook 'go-mode-hook
                (lambda ()
                  (set (make-local-variable 'company-backends) '(company-go))
                  ))
      )

    (use-package go-rename)

    (use-package flycheck-gometalinter
      :ensure t
      :config
      (flycheck-gometalinter-setup)
      )
    )

  ;; Elisp
  (progn
    (evil-define-key 'normal emacs-lisp-mode-map
      (kbd "<f2>") 'describe-function
      (kbd "<f3>") 'find-function
      (kbd "C-<f2>") 'describe-variable
      (kbd "C-<f3>") 'find-variable-at-point
      )
    )

  ;; Markdown
  (use-package markdown-mode)

  ;; Antlr
  (progn
    (require 'antlr-mode)
    (add-to-list 'auto-mode-alist '("\\.g4$" . antlr-v4-mode))
    )

  ;; Org mode
  (progn
    (evil-define-key 'normal evil-org-mode-map
      (kbd "<key-chord> cn") 'org-clock-in
      (kbd "<key-chord> co") 'org-clock-out
      (kbd "<key-chord> cq") 'org-clock-cancel
      (kbd "<key-chord> cr") 'org-clock-in-last)

    (add-hook 'org-mode-hook
              (lambda()
                (key-chord-mode t)))

    (use-package key-chord
      :config
      (setq key-chord-two-keys-delay .3)
      )
    )

  ;; Code
  (progn
    (use-package web-mode
      :config

      (evil-define-key 'normal web-mode-map
        (kbd "M-R") 'tern-rename-variable
        )

      (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
      (add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
      (add-to-list 'auto-mode-alist '("\\.css$" . web-mode))
      (add-to-list 'auto-mode-alist '("\\.tsx$" . web-mode))

      (setq web-mode-indent-style 2
            web-mode-markup-indent-offset 2
            web-mode-css-indent-offset 2
            web-mode-enable-css-colorization t
            web-mode-code-indent-offset 2
            web-mode-attr-indent-offset 2
            )

      (add-hook 'web-mode-hook
                (lambda ()
                  (when (equal web-mode-content-type "javascript")
                    (tern-mode t)
                    (web-mode-set-content-type "jsx")
                    (yas-activate-extra-mode 'js-mode)
                    (setq-local web-mode-auto-quote-style 2)
                    )))

      (add-hook 'web-mode-hook
                (lambda ()
                  (when (string-equal "tsx" (file-name-extension buffer-file-name))
                    (tide-setup)
                    (tide-hl-identifier-mode)
                    )))
      )

    (use-package company
      :config
      (global-company-mode)
      (add-to-list 'company-dabbrev-code-modes 'web-mode)
      (setq company-idle-delay 0.2
            company-minimum-prefix-length 1
            company-selection-wrap-around t)
      (define-key company-active-map [tab] 'company-select-next-or-abort)
      (define-key company-active-map [backtab] 'company-select-previous-or-abort)
      (define-key company-active-map (kbd "<S-tab>") 'company-select-previous-or-abort)
      (define-key company-active-map (kbd "<C-SPC>") 'company-complete-selection)
      )

    (use-package flycheck
      :config
      (global-flycheck-mode)
      (setq flycheck-emacs-lisp-load-path 'inherit)
      (flycheck-add-mode 'javascript-eslint 'javascript-mode)
      (flycheck-add-mode 'javascript-eslint 'web-mode)
      (flycheck-add-mode 'typescript-tslint 'web-mode)
      )

    (use-package yasnippet
      :config
      (yas-global-mode)

      ;; Add yasnippet support for all company backends
      ;; https://github.com/syl20bnr/spacemacs/pull/179
      (defvar company-mode/enable-yas t "Enable yasnippet for all backends.")

      (defun company-mode/backend-with-yas (backend)
        (if (or (not company-mode/enable-yas)
                (and
                 (listp backend)
                 (member 'company-yasnippet backend)))
            backend
          (append (if (consp backend) backend (list backend)) '(:with company-yasnippet))))

      (setq company-backends (mapcar 'company-mode/backend-with-yas company-backends))
      )

    (use-package rainbow-mode)

    (use-package adaptive-wrap
      :config
      (when (fboundp 'adaptive-wrap-prefix-mode)
        (defun hook-activate-adaptive-wrap-prefix-mode ()
          "Toggle `visual-line-mode' and `adaptive-wrap-prefix-mode' simultaneously."
          (adaptive-wrap-prefix-mode (if visual-line-mode 1 -1)))
        (add-hook 'visual-line-mode-hook 'hook-activate-adaptive-wrap-prefix-mode))
      )
    )

  ;; UI
  (progn
    (if (display-graphic-p)
        (use-package git-gutter-fringe
          :config
          (global-git-gutter-mode)
          )
      )

    (if (not (display-graphic-p))
        (use-package git-gutter
          :config
          (global-git-gutter-mode +1)
          )
      )

    (use-package form-feed
      :config
      ;; Show ^L (page breaks) as a line in help mode
      (add-hook 'help-mode-hook 'form-feed-mode)
      )

    (use-package buffer-move
      :config
      (define-key evil-normal-state-map (kbd "M-H") 'buf-move-left)
      (define-key evil-normal-state-map (kbd "M-J") 'buf-move-down)
      (define-key evil-normal-state-map (kbd "M-K") 'buf-move-up)
      (define-key evil-normal-state-map (kbd "M-L") 'buf-move-right)
      )

    (use-package neotree
      :config

      (defun neotree-projectile-toggle ()
        (interactive)
        ;; If neotree window open
        (if (neo-global--window-exists-p)
            ;; Hide it
            (neotree-hide)
          ((lambda ()
             ;; Else if in projectile project
             (if (projectile-project-p)
                 ;; Open neotree in projectile directory
                 (neotree-projectile-action)
               ;; Else if not in projectile project open neotree in default directory
               (neotree-dir default-directory)
               ))))
        )

      (evil-leader/set-key "n" 'neotree-projectile-toggle)

      (add-hook 'neotree-mode-hook
                (lambda ()
                  ;; Remove image-map binding
                  (define-key image-map (kbd "r") nil)
                  (define-key image-map (kbd "o") nil)

                  (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
                  (define-key evil-normal-state-local-map (kbd "<return>") 'neotree-enter)
                  (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                  (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)

                  (define-key evil-normal-state-local-map (kbd "C") 'neotree-change-root)
                  (define-key evil-normal-state-local-map (kbd "u") 'neotree-select-up-node)

                  (define-key evil-normal-state-local-map (kbd "i") 'neotree-enter-horizontal-split)
                  (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)

                  (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
                  (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                  ))
      )

    (use-package multi-term
      :config
      (setq multi-term-dedicated-select-after-open-p t
            multi-term-dedicated-window-height 8)

      (define-key term-raw-map (kbd "C-a") nil)

      ;; Fast window traversal in term mode
      (evil-define-key 'insert term-raw-map
        (kbd "C-h") 'evil-window-left
        (kbd "C-j") 'evil-window-down
        (kbd "C-k") 'evil-window-up
        (kbd "C-l") 'evil-window-right
        (kbd "C-d") '(lambda() (interactive) (term-send-raw-string "\C-d"))
        (kbd "C-c") '(lambda() (interactive) (term-send-raw-string "\C-c"))
        (kbd "C-a") '(lambda() (interactive) (term-send-raw-string "\C-a"))          ;; Go to beginning of line
        (kbd "C-e") '(lambda() (interactive) (term-send-raw-string "\C-e"))          ;; Go to end of line
        (kbd "C-w") '(lambda() (interactive) (term-send-raw-string "\C-w"))          ;; Delete word before cursor
        (kbd "C-u") '(lambda() (interactive) (term-send-raw-string "\C-u"))          ;; Clear entire line
        (kbd "C-S-k") '(lambda() (interactive) (term-send-raw-string "\C-k"))        ;; Clear from cursor position to end of line C-k is already bound to evil-window-up so C-S-k is used
        (kbd "<C-left>") '(lambda() (interactive) (term-send-raw-string "\e[1;5D"))
        (kbd "<C-right>") '(lambda() (interactive) (term-send-raw-string "\e[1;5C"))
        (kbd "<backtab>") '(lambda() (interactive) (term-send-raw-string "\e[Z"))    ;; Allow backtab to trigger completion combine with bindkey '^[[Z' reverse-menu-complete in .zshrc
        (kbd "<S-insert>") 'term-paste
        )

      (evil-define-key 'normal term-raw-map (kbd "p") 'term-paste)

      (defun advice/multi-term (orig-fun &rest args)
        "Opens terminal in projectile project directory"
        (if (projectile-project-p)
            (progn
              (projectile-with-default-dir (projectile-project-root) (apply orig-fun args))
              )
          (apply orig-fun args)))

      (advice-add 'multi-term :around 'advice/multi-term)

      (defun advice/multi-term-kill-buffer-hook (&rest args)
        (if (eq major-mode 'term-mode)
            (delete-window))
        )

      (advice-add 'multi-term-kill-buffer-hook :after 'advice/multi-term-kill-buffer-hook)

      (add-hook 'term-mode-hook
                (lambda ()
                  (define-key term-raw-map (kbd "C-c C-c") '(lambda() (interactive) (term-interrupt-subjob) (end-of-buffer))) ;; Move to end of buffer when using C-c C-c
                  (toggle-truncate-lines 1)
                  (when (fboundp 'yas-minor-mode)
                    (yas-minor-mode -1))
                  ))

      ;; https://gist.github.com/jpanganiban/2157d3e16b42b1959560
      (defcustom windmove-pre-move-hook nil
        "Hook run before windmove select is triggered."
        :group 'windmove
        :type 'hook)

      (defcustom windmove-post-move-hook nil
        "Hook run after windmove select is triggered."
        :group 'windmove
        :type 'hook)

      (defun advice/windowmove-do-window-select (orig-fun &rest args)
        "Run pre and post hooks for windowmove-do-select passing ORIG-FUN the ARGS."
        (run-hooks 'windmove-pre-move-hook)
        (apply orig-fun args)
        (run-hooks 'windmove-post-move-hook))

      (advice-add 'windmove-do-window-select :around 'advice/windowmove-do-window-select)

      (add-hook 'windmove-post-move-hook
                (lambda ()
                  (when (derived-mode-p 'term-mode)
                    (evil-insert-state)
                    )
                  ))

      (cond
       ((equal system-type 'darwin)
        (evil-define-key 'insert term-raw-map
          (kbd "s-v") 'term-paste))
       )
      )

    (require 'move-border)
    )

  ;; Misc
  (progn
    (use-package hydra
      :config

      (defhydra hydra-tmux-mode
        (global-map "C-a")
        "Tmux mode"
        ("s" (lambda() (interactive) (evil-window-split) (multi-term)) "Split window horizontally and launch term")
        ("v" (lambda() (interactive) (evil-window-vsplit) (multi-term)) "Split window vertically and launch term")
        ("C-h" move-border-left "Move border left 3")
        ("C-j" move-border-down "Move border down 3")
        ("C-k" move-border-up "Move border up 3")
        ("C-l" move-border-right "Move border right 3")

        ("C-<left>" (lambda() (interactive) (move-border-left 1)) "Move border left 1")
        ("C-<down>" (lambda() (interactive) (move-border-down 2)) "Move border down 1")
        ("C-<up>" (lambda() (interactive) (move-border-up 1)) "Move border up 1")
        ("C-<right>" (lambda() (interactive) (move-border-right 1)) "Move border right 1")
        )
      (hydra-set-property 'hydra-tmux-mode :verbosity 0)
      )
    )
  )

(provide 'init)
;;; init.el ends here
