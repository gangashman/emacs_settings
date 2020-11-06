;;; Settings --- symmary:
;;; Commentary:
;;; Code:
(message "Init main.py")

(require 'package)
(setq package-enable-at-startup nil)

;; https://emacs.stackexchange.com/a/2989
(setq package-archives
      '(("elpa"     . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("melpa-stable" . 10)
        ("elpa"     . 5)
        ("melpa"        . 0)))
(package-initialize)

(setq x-gtk-use-system-tooltips t)
(setq pos-tip-background-color "gray20")
(setq pos-tip-saved-max-width-height 100)

;; How to overwrite text by yank in Emacs?
(delete-selection-mode 1)

(setq backup-directory-alist '(("." . "~/emacs.d/backups/")))

(tool-bar-mode -1)

(remove-hook 'kill-emacs-hook 'ac-comphist-save)

(visual-line-mode t)

(global-set-key (kbd "C-x C-n") (lambda() (interactive)(find-file (concat dropbox_path "text.org"))))

(setq truncate-lines nil)

;; This tells Emacs not to warn you about anything except problems
(setq warning-minimum-level :emergency)

(message "Inig desktop save settings")
;; Automatically save and restore sessions
(setq desktop-load-locked-desktop t)

(setq desktop-dirname             "~/.emacs-save/"
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$"
      desktop-load-locked-desktop t
      desktop-auto-save-timeout   10)

(unless (file-exists-p desktop-dirname) (make-directory desktop-dirname t))

;; Note that this will affect all histories, not just the shell.
;; Save sessions history
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring search-ring regexp-search-ring compile-history log-edit-comment-ring)
      savehist-file "~/.emacs-save/savehist")
(savehist-mode t)
(setq history-delete-duplicates t)
(setq comint-input-ignoredups t)

(setq
   backup-by-copying t
   backup-directory-alist
    '(("~/.saves/"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

(setq make-backup-files nil)

(setq auto-save-file-name-transforms
  `(("~/.emacs-saves/" t)))

(desktop-save-mode 1)

(message "Init emacs settings")

(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(5))

(menu-bar-mode -1)
(global-set-key [f9] 'toggle-menu-bar-mode-from-frame)
(set-frame-parameter nil 'undecorated nil)

;; How to get rid of "Loading a theme can run Lisp code. Really load? (y or n) " message?
(set-variable 'sml/no-confirm-load-theme t)

;; No more typing the whole yes or no. Just y or n will do.
(fset 'yes-or-no-p 'y-or-n-p)

;; To make the cursor even more visible
(global-hl-line-mode)

(setq ring-bell-function 'ignore)

(display-time-mode 1)

;; Finally you can toggle the display of scroll bars on all frames
(scroll-bar-mode -1)

;; if you want it for every buffer
(global-linum-mode t)

;; From Pragmatic Emacs a more concise way to kill the buffer.
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; If you enable winner-mode, you get something akin to a stack-based
;; undo/redo functionality for all your window configuration changes.
;; By default, C-c <left> gets bound to winner-undo, while C-c <right> performs winner-redo.
(winner-mode 1)
(global-set-key (kbd "C-c [") `wg-undo-wconfig-change)
(global-set-key (kbd "C-c ]") `wg-redo-wconfig-change)

(global-set-key (kbd "C-=") `comment-region)

(set-variable 'dov-view-continues t)

(show-paren-mode 1)

(add-to-list 'completion-styles 'initials t)

(if (find-font (font-spec :name "Hack"))
    (set-face-attribute 'default nil :font "Hack" :height 83)
  (error "Install Hack font from https://github.com/source-foundry/Hack")
  )

(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)

;; Don’t open files from the workspace in a new frame
(setq ns-pop-up-frames nil)

(setq display-battery-mode 1)

(global-set-key (kbd "C-c i") `linum-mode)

(message "Init base hotkeys")

(global-set-key (kbd "<f2>") 'bookmark-jump)

(global-set-key (kbd "<f2>") 'bookmark-jump)
(global-set-key (kbd "<f3>") 'bookmark-set)
(global-set-key (kbd "<f4>") 'bookmark-bmenu-list)
(setq bookmark-default-file (concat user-emacs-directory ".emacs-save"))

;; (global-set-key (kbd "<C-M-tab>") 'next-buffer)
;; (global-set-key (kbd "<C-M-iso-lefttab>") 'previous-buffer)

(global-set-key (kbd "<C-tab>") (lambda () (interactive) (other-window 1)))
(global-set-key (kbd "<C-iso-lefttab>") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "<C-S-tab>") (lambda () (interactive) (other-window -1)))

(global-set-key (kbd "<f10>") 'toggle-frame-fullscreen)

;; Hide/Show
;; package-list-packages
(global-unset-key (kbd "C-x l"))
(global-set-key (kbd "C-x l h") `hide-subtree)
(global-set-key (kbd "C-x l s") `show-subtree)
(global-set-key (kbd "C-x l a") `show-all)

;; Open buffers list in the same frame
;; (global-set-key "\C-x\C-b" 'buffer-menu)
(global-unset-key "\C-x\C-b")
(global-set-key (kbd "C-x y") `repeat-complex-command)

(global-set-key (kbd "C-x C-d") (lambda() (interactive)(find-file (concat settings_path "main.el"))))

(setq whitespace-line-column 1000)
;; (setq global-whitespace-mode 1)
(global-set-key (kbd "C-c h") `whitespace-mode)

(global-set-key (kbd "C-x c") `list-colors-display)
(global-set-key (kbd "C-h") 'backward-delete-char-untabify)
(global-set-key (kbd "M-h") 'backward-delete-word)
(global-set-key (kbd "M-d") 'delete-word)
(global-set-key (kbd "C-c r") `revert-buffer)
;; (global-set-key (kbd "C-r") `replace-string)

;; (global-set-key (kbd "C-x r r") `bookmark-jump)
(global-set-key (kbd "C-x r s") `bookmark-set)
(global-set-key (kbd "C-x r d") `bookmark-delete)

(global-set-key (kbd "C-x b") 'ibuffer-list-buffers)

(global-unset-key (kbd "C-o"))

(global-unset-key (kbd "C-j"))
(global-set-key (kbd "C-.") `undo)
(global-set-key (kbd "C-x t") 'dired)
;; (global-set-key (kbd "<C-right>") 'py-shift-right)
;; (global-set-key (kbd "<C-left>") 'py-shift-left)

(defun next-with-center (lines)
  "Move LINES lines and center."
  (next-line lines)
  (recenter))
(global-set-key (kbd "C-M-n")
                (lambda () (interactive) (next-with-center 5)))
(defun previous-with-center (lines)
  "Move LINES lines and center."
  (previous-line lines)
  (recenter))
(global-set-key (kbd "C-M-p")
                (lambda () (interactive) (previous-with-center 5)))

;; Windows/frames
(global-set-key (kbd "<C-S-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "<C-S-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-S-up>") 'enlarge-window)
(global-set-key (kbd "<C-S-down>") 'shrink-window)

(add-hook 'before-save-hook
  (lambda ()
    (untabify (point-min) (point-max))
    ))

(message "Init use-package")
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package quelpa
  :ensure t
  )

(use-package quelpa-use-package
  :ensure t
  :init (setq quelpa-update-melpa-p nil)
  :config (quelpa-use-package-activate-advice)
  )

(use-package auto-complete
  :quelpa (auto-complete :fetcher github :repo "auto-complete/auto-complete")
  :ensure t
  :config
  (ac-config-default)
  )

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe)
  )

(use-package ibuffer-projectile
  :ensure t
  :config
  (add-hook 'ibuffer-hook
    (lambda ()
      (ibuffer-projectile-set-filter-groups)
      ;; (ibuffer-switch-to-saved-filter-groups "default")
      ))
  )

(use-package hydra
  :ensure t
  )

(use-package pretty-hydra
  :ensure t
  )

(use-package realgud
  :ensure t
  )

(use-package bui
  :ensure t
  )

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs (list
                          (concat settings_path "snippets")
                          ))
  (yas-global-mode 1)
  (global-set-key (kbd "<f1> s") 'yas/describe-tables)
  )

;; https://github.com/AndreaCrotti/yasnippet-snippets
(use-package yasnippet-snippets
  :ensure t
  )

(use-package smerge-mode
  :ensure t
  )

;; smerge

(setq smerge-command-prefix "\C-c v")
(pretty-hydra-define hydra-smerge
  (:color blue)
  ("smerge-mode-map"
   (("n" smerge-next)
    ("p" smerge-previous)
    ("c" smerge-keep-current)
    ("m" smerge-keep-mine)
    ("o" smerge-resolve)
    ("r" smerge-ediff)
    ("R" smerge-resolve-all)
    )
   "Bookmarks"
   (("a" w3m-bookmark-add-current-url)
    ("M-a" w3m-bookmark-add-this-url)
    ("v" w3m-bookmark-view)
    ))
  )

(define-key smerge-mode-map (kbd "<down>") 'smerge-next)
(define-key smerge-mode-map (kbd "n") 'smerge-next)
(define-key smerge-mode-map (kbd "<up>") 'smerge-prev)
(define-key smerge-mode-map (kbd "p") 'smerge-prev)
(define-key smerge-mode-map (kbd "с") 'smerge-keep-current)
(define-key smerge-mode-map (kbd "m") 'smerge-keep-mine)
(define-key smerge-mode-map (kbd "o") 'smerge-keep-other)
(define-key smerge-mode-map (kbd "r") 'smerge-resolve)
(define-key smerge-mode-map (kbd "R") 'smerge-resolve-all)
;; (global-set-key (kbd "C-x b") #'hydra-smerge/body)

(use-package eww
  :ensure t
  )
;; (global-set-key (kbd "C-x w") (lambda() (interactive)(eww "google.com")))
(define-key eww-mode-map (kbd "e") #'eww-browse-with-external-browser)

(pretty-hydra-define hydra-eww
  (:color blue)
  ("Navigation"
   (("p" eww-previous-url)
    ("r" eww-forward-url)
    ("e" eww-browse-with-external-browser)
    ("g" eww-reload)
    ("w" eww-copy-page-url)
    ("v" eww-view-source)
    ))
  )

;; (define-key eww-mode-map (kbd "C-x b") #'hydra-eww/body)

(use-package evil
  :ensure t
  )

;; (use-package perspective
;;   :ensure t
;;   :config
;;   (persp-mode)
;;   )
                   
;; (use-package vlfi
;;   :quelpa (vlfi :fetcher github :repo "m00natic/vlfi")
;;   :ensure t
;;   :config
;;   (custom-set-variables
;;    '(vlf-application 'dont-ask))
;;   )

;; Available only on mercurial versions 1.9 or higher
(setq monky-process-type 'cmdserver)
(global-set-key (kbd "C-c l") 'monky-status)

(add-to-list 'custom-theme-load-path (concat settings_path "emacsd/themes/"))

;; Hideshow
(global-set-key (kbd "C-c C-g") 'hs-show-all)
(global-set-key (kbd "C-c C-h") 'hs-hide-all)
(add-hook 'ropemacs-mode-hook     'hs-minor-mode)
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

(message "Init magit")
;; Install the Git frontend Magit
;; git config --global status.showUntrackedFiles all
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-c m") 'magit-status)
  (global-set-key (kbd "C-c C-m") 'magit-dispatch-popup)
  (global-set-key (kbd "C-x v h") 'magit-log-buffer-file)
  (global-set-key (kbd "C-x v b") 'magit-blame)

  (define-key magit-mode-map (kbd "<C-tab>") (lambda () (interactive) (other-window 1)))
  (define-key magit-mode-map (kbd "M-1") 'winum-select-window-1)
  (define-key magit-mode-map (kbd "M-2") 'winum-select-window-2)
  (define-key magit-mode-map (kbd "M-3") 'winum-select-window-3)
  (define-key magit-mode-map (kbd "M-4") 'winum-select-window-4)
  (define-key magit-mode-map (kbd "1") 'magit-section-show-level-1-all)
  (define-key magit-mode-map (kbd "2") 'magit-section-show-level-2-all)
  (define-key magit-mode-map (kbd "3") 'magit-section-show-level-3-all)
  (define-key magit-mode-map (kbd "4") 'magit-section-show-level-4-all)
  )

(message "Init winum")
(use-package winum
  :ensure t
  :config
  ;; (setq winum-ignored-buffers-regexp (list (rx "*neotree*")))
  (setq window-numbering-scope 'global)
  (winum-mode)
  (global-set-key (kbd "M-1") 'winum-select-window-1)
  (global-set-key (kbd "M-2") 'winum-select-window-2)
  (global-set-key (kbd "M-3") 'winum-select-window-3)
  (global-set-key (kbd "M-4") 'winum-select-window-4)
  (global-set-key (kbd "M-5") 'winum-select-window-5)
  (global-set-key (kbd "M-6") 'winum-select-window-6)
  (global-set-key (kbd "M-7") 'winum-select-window-7)
  (global-set-key (kbd "M-8") 'winum-select-window-8)
  )

(message "Init multiple-cursors")
(use-package multiple-cursors
  :ensure t
  :config
  ;; Multicursors
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-с C->") 'mc/skip-to-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-с C-<") 'mc/skip-to-previous-like-this)
  (global-set-key (kbd "<C-C-down-mouse-1>") 'mc/add-cursor-on-click)
  (global-set-key (kbd "C-c <mouse-1>") 'mc/add-cursor-on-click)
  (global-set-key (kbd "C-c n") 'mc/insert-numbers)
  ;; (global-set-key (kbd "C-c l") 'mc/insert-letters)
  ;; (global-set-key (kbd "C-c c") 'mc/edit-lines)
  (global-set-key (kbd "C-c C-n") 'mc/mark-next-like-this-word) ; choose same word next
  (global-set-key (kbd "C-c C-p") 'mc/mark-previous-word-like-this) ; choose same word previous
  )

(message "Init back-button")
(use-package back-button
  :ensure t
  :config
  (back-button-mode 1)
  ;; Back navigation
  (global-set-key (kbd "M-n") 'back-button-local-forward)
  (global-set-key (kbd "M-p") 'back-button-local-backward)
  ;; (global-set-key (kbd "<M-right>") 'back-button-global-forward)
  ;; (global-set-key (kbd "<M-left>") 'back-button-global-backward)
  (global-set-key (kbd "C-M-[") 'back-button-global-forward)
  (global-set-key (kbd "C-M-]") 'back-button-global-backward))

(use-package company
  :quelpa (company-mode :fetcher github :repo "company-mode/company-mode")
  :ensure t
  :config
  (global-company-mode)
  (define-key company-active-map (kbd "C-h") 'backward-delete-char-untabify)
  (setq company-tooltip-limit 10
        company-idle-delay 0.00
        company-minimum-prefix-length 3
        company-show-numbers t
        company-tooltip-align-annotations t)

  (setq company-backends
      '((;; company-keywords
         ;; company-capf
         company-yasnippet
         company-anaconda
         )
        (company-abbrev company-dabbrev)
        ))

  (set-face-attribute 'company-tooltip nil
                    :background "#0f2c57"
                    :foreground "LightSteelBlue1"
                    :inherit 'company-tooltip
                    :underline nil
                    :weight 'normal)
  (set-face-attribute 'company-tooltip-common nil
                      :background nil
                      :foreground "DodgerBlue1"
                      :inherit 'company-tooltip
                      :underline nil
                      :weight 'normal)
  )

(setq use-lsp nil)
(if use-lsp
  (message "Init lsp-mode")
  (use-package lsp-mode
    :quelpa (lsp-mode :fetcher github :repo "emacs-lsp/lsp-mode")
    :ensure t
    :config
    (setq lsp-auto-guess-root t)
    (add-hook 'rust-mode-hook #'lsp)

    ;; sudo pip install 'python-language-server[all]'
    ;; (add-hook 'python-mode-hook #'lsp)

    (setq lsp-pyls-plugins-jedi-references-enabled t)
    (setq lsp-pyls-server-command (quote ("pyls")))

    (setq lsp-document-highlight-delay 0.1)
    (setq lsp-enable-semantic-highlighting t)
    (setq lsp-enable-symbol-highlighting t)
    (setq lsp-symbol-highlighting-skip-current t)

    (setq lsp-enable-indentation nil)
    (setq lsp-enable-snippet t)
    (setq lsp-prefer-flymake nil)

    (setq lsp-diagnostic-package :none)

    (setq lsp-signature-auto-activate nil)

    ;; (define-key lsp-mode-map (kbd "C-i") 'lsp-describe-thing-at-point)
    ;; (define-key lsp-mode-map (kbd "C-o") #'lsp-find-definition)

    (define-key lsp-mode-map (kbd "C-r r") 'lsp-ui-peek-find-references)
    (define-key lsp-mode-map (kbd "C-r i") 'lsp-ui-peek-find-implementation)

    (setq lsp-modeline-diagnostics-scope :project)
    )

  (use-package lsp-python-ms
    :quelpa (lsp-python-ms :fetcher github :repo "emacs-lsp/lsp-python-ms")
    :ensure t
    :config
    (setq lsp-python-ms-auto-install-server t)
    ;; (setq lsp-python-ms-executable (executable-find "python-language-server"))
    )

  (use-package helm-lsp
    :quelpa (helm-lsp :fetcher github :repo "emacs-lsp/helm-lsp")
    :ensure t
    :config
    (define-key lsp-mode-map (kbd "C-x o") 'xref-find-apropos)
    )

  (use-package lsp-ui
    :quelpa (lsp-ui :fetcher github :repo "emacs-lsp/lsp-ui")
    :ensure t
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)

    (setq lsp-ui-doc-enable nil)
    (setq lsp-ui-flycheck-enable t)
    (setq lsp-ui-peek-enable nil)
    (setq lsp-ui-sideline-enable nil)

    (setq lsp-ui-doc-alignment (quote frame))
    (setq lsp-ui-doc-delay 0.2)
    (setq lsp-ui-doc-max-height 30)
    (setq lsp-ui-doc-max-width 100)
    (setq lsp-ui-doc-use-webkit nil)

    (global-set-key (kbd "<C-M-return>") 'lsp-ui-imenu)

    ;; (define-key python-mode-map (kbd "C-o") #'lsp-ui-peek-find-definitions)
    )

    (use-package company-lsp
      :quelpa (company-lsp :fetcher github :repo "tigersoldier/company-lsp")
      :ensure t
      :config
      (push 'company-lsp company-backends)
      (setq company-lsp-async nil)
      )
  )

;; Rust
(message "Rust")
;; cargo +nightly install racer
;; rustup toolchain add nightly
;; rustup component add rls rust-analysis rust-src

;; For windows:
;; rustup component add rls --toolchain stable-x86_64-pc-windows-msvc

(message "rust-mode")
(use-package rust-mode
  :ensure t
  :config
  ;; cargo install racer
  (setq racer-cmd "~/.cargo/bin/racer")

  ;; rustup component add rust-src
  ;; rustc --print sysroot /lib/rustlib/src/rust/src
  (setq racer-rust-src-path "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")

  ;; Configure Emacs to activate racer when rust-mode starts
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  
  ;; (define-key rust-mode-map (kbd "C-i") #'racer-describe-tooltip)
  (define-key rust-mode-map (kbd "C-i") #'lsp-describe-thing-at-point)
  
  (define-key rust-mode-map (kbd "C-o") #'racer-find-definition)

  (define-key rust-mode-map (kbd "C-r r") 'lsp-ui-peek-find-references)
  (define-key rust-mode-map (kbd "C-r i") 'lsp-ui-peek-find-implementation)
  )

(message "racer")
(use-package racer
  :ensure t
  )

(message "ron-mode")
(use-package ron-mode
  :quelpa (ron-mode :fetcher github :repo "rhololkeolke/ron-mode")
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.ron\\'" . ron-mode))
  )

(message "cargo")
(use-package cargo
  :ensure t
  )

;; (use-package rainbow-delimiters
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Smartparens is a minor mode for dealing with pairs in Emacs. 
;; (use-package smartparens
;;   :ensure t
;;   :config
;;   (smartparens-global-mode))

;; (use-package bm
;;   :ensure t
;;   :config
;;   (global-set-key (kbd "<C-f2>") 'bm-toggle)
;;   (global-set-key (kbd "<f2>")   'bm-next)
;;   (global-set-key (kbd "<S-f2>") 'bm-previous))

(use-package yaml-mode
  :ensure t
  )

(use-package dockerfile-mode
  :quelpa (dockerfile-mode :fetcher github :repo "spotify/dockerfile-mode")
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
  )

(use-package google-translate
  :ensure t
  :config
  (setq google-translate-pop-up-buffer-set-focus t)
  (setq google-translate-translation-directions-alist '(("en" . "ru")))
  ;; (global-set-key "\C-ct" 'google-translate-smooth-translate)
  )

(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)

(use-package dired-single
  :ensure t
  :config
  (define-key dired-mode-map [return] 'dired-single-buffer)
  (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
  (define-key dired-mode-map "^" 'dired-single-up-directory)
  (define-key dired-mode-map (kbd "C-M-m") 'dired-single-buffer)
  )

(use-package dired-sidebar
  :ensure t
  :config
  (global-set-key (kbd "C-c t") 'dired-sidebar-show-sidebar)
  )

(use-package neotree
  :ensure t
  :config
  (setq neo-autorefresh nil)
  
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))
  ;; (global-set-key (kbd "<f8>") 'neotree-project-dir)
  (global-unset-key (kbd "C-t"))
  ;; (global-set-key (kbd "C-t") 'neotree-toggle)
  (global-set-key (kbd "C-t") 'neotree-project-dir)
  (setq neo-window-fixed-size t)
  (setq neo-window-width 26)
  )

;; https://github.com/emacs-pe/company-racer
;; (use-package company-racer
;;   :ensure t
;;   :config
;;   (eval-after-load "company"
;;     (add-to-list 'company-backends 'company-racer))
;;   )

(use-package yascroll
  :ensure t
  :config
  (global-yascroll-bar-mode 1)
  (setq yascroll:delay-to-hide nil)
  )

;; (use-package flycheck-rust
;;   :ensure t
;;   :config
;;   (with-eval-after-load 'rust-mode
;;     (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
;;   )

;; (use-package ess
;;   :ensure t)

(message "Init helm")
(use-package helm
  :ensure t
  :init
  (setq helm-mode t)
  :config
  (setq bottom-buffers ())

  (setq helm-split-window-in-side-p t)
  ;; (global-set-key (kbd "C-x b") 'helm-buffers-list)
  ;; (global-set-key (kbd "C-x s") 'helm-grep-do-git-grep)
  (global-set-key (kbd "C-S-SPC") 'helm-buffers-list)
  (global-unset-key (kbd "C-x C-f"))
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (global-set-key (kbd "M-RET") 'helm-imenu)
  (define-key helm-map (kbd "C-h") nil)
  (global-set-key (kbd "C-x r r") #'helm-filtered-bookmarks)

  (defun helm-buffers-sort-transformer@donot-sort (_ candidates _)
    candidates)

  (advice-add 'helm-buffers-sort-transformer :around 'helm-buffers-sort-transformer@donot-sort)
  (setq helm-boring-buffer-regexp-list (list
                                        (rx "*magit-") (rx "*helm") (rx "*py") (rx "*echo")
                                        (rx "*Fly") (rx "*mini") (rx "*Qua") (rx "*Neo")
                                        (rx "*Compa") (rx "*code") (rx "*http")
                                        (rx "*anaco") (rx "*tip") (rx "*xwi") (rx "magit-")
                                        (rx "*server") (rx "*which") (rx "magit")))
  )

(use-package restclient
  :quelpa (restclient :fetcher github :repo "pashky/restclient.el")
  :ensure t
  )

(use-package helm-projectile
  :ensure t
  :config
  (global-unset-key (kbd "C-M-j"))
  (global-set-key (kbd "C-M-j") 'helm-projectile-switch-project)
  (global-set-key (kbd "C-SPC") 'helm-projectile-switch-to-buffer)
  )

(use-package projectile
  :ensure t
  :config
  (projectile-mode t))

(use-package counsel-projectile
  :ensure t
  :config
  ;; (counsel-projectile-mode)
  ;; (global-set-key (kbd "C-x p f") 'counsel-projectile-find-file)

  ;; (global-set-key (kbd "C-M-s") 'counsel-projectile-git-grep)
  (global-set-key (kbd "C-x s")
                  (lambda () (interactive)
                    (counsel-git-grep nil nil "git --no-pager grep -n --no-color -I -e \"%s\" -- \"*.py\" \"*.html\"")))
  (global-set-key (kbd "C-M-s") 'counsel-git-grep)

  (global-set-key (kbd "C-x f") 'counsel-projectile-find-file)
  )

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  ;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "C-c g") 'counsel-git)
  ;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
  ;; (global-set-key (kbd "C-c k") 'counsel-ag)
  ;; (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
  )

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-j") 'er/expand-region)
  (global-set-key (kbd "C-S-J") (lambda () (interactive) (er/expand-region -1)))
  )

(use-package flycheck
  :quelpa (flycheck :fetcher github :repo "flycheck/flycheck")
  :ensure t
  :config

  (global-flycheck-mode)
  ;; (flycheck-julia-setup)

  (setq flycheck-highlighting-mode (quote symbols))

  (global-set-key (kbd "M-z") 'flycheck-previous-error)
  (global-set-key (kbd "C-z") 'flycheck-next-error)
  (global-set-key (kbd "C-M-z") 'flycheck-copy-errors-as-kill)

  ;; (add-to-list 'flycheck-disabled-checkers 'lsp)

  (flycheck-add-next-checker 'python-flake8 'python-pylint)
  (flycheck-add-next-checker 'python-pylint 'python-mypy)
  (flycheck-add-next-checker 'python-mypy 'python-pycompile)

  (setq flycheck-python-mypy-config `("mypy.ini" ,(concat settings_path "configs/mypy.ini")))
  (setq flycheck-flake8rc (concat settings_path "configs/flake8rc"))
  (setq flycheck-pylintrc (concat settings_path "configs/.pylintrc"))
  )

(use-package flycheck-popup-tip
  :ensure t
  :config
  (setq flycheck-pos-tip-timeout 100000)
  (eval-after-load 'flycheck
  (if (display-graphic-p)
      (flycheck-pos-tip-mode)
    (flycheck-popup-tip-mode)))
  )

(message "Web-mode")
(setq js-indent-level 2)
(use-package web-mode
  :ensure t
  :config
  (setq web-mode-enable-auto-indentation nil)

  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))
  )

(use-package yafolding
  :ensure t
  :config

  (define-key yafolding-mode-map (kbd "<C-left>") 'yafolding-hide-element)
  (define-key yafolding-mode-map (kbd "<C-right>") 'yafolding-show-element)
  (define-key yafolding-mode-map (kbd "<C-up>") 'yafolding-hide-parent-element)
  (define-key yafolding-mode-map (kbd "<C-down>") 'yafolding-toggle-all)
  )

(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode)
  (add-hook 'css-mode-hook  'emmet-mode)
  (add-hook 'web-mode-hook  'emmet-mode)

  (add-hook 'css-mode-hook 'add-emmet-expand-to-smart-tab-completions)
  (add-hook 'sgml-mode-hook 'add-emmet-expand-to-smart-tab-completions)
  (setq emmet-preview-default nil)

  (define-key web-mode-map (kbd "C-o") 'emmet-expand-line)
  )

(use-package epc
  :ensure t)

;; sudo apt-get install sqlformat
(use-package format-sql
  :ensure t)

(use-package pos-tip
  :ensure t)

(use-package csv-mode
  :ensure t)

(message "Shell")
(use-package aweshell
  :quelpa (aweshell :fetcher github :repo "manateelazycat/aweshell")
  :ensure t
  :config
  (setq eshell-up-print-parent-dir nil)

  (set-face-attribute 'epe-pipeline-delimiter-face nil :foreground "#4169e1")
  (set-face-attribute 'epe-pipeline-user-face nil :foreground "cornflower blue")
  (set-face-attribute 'epe-pipeline-host-face nil :foreground "dodger blue")
  (set-face-attribute 'epe-pipeline-time-face nil :foreground "cornflower")
  )

(use-package multi-term
  :quelpa (multi-term :fetcher github :repo "manateelazycat/multi-term")
  :ensure t
  :config
  (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
  )

(if (string-equal system-type "windows-nt")
  (use-package powershell
  :ensure t
  :config
  (global-set-key (kbd "C-x m") `powershell)
  )
  (setq shell-file-name "/bin/bash")
  (progn
    (global-set-key (kbd "C-x m") `shell)
    (define-key shell-mode-map (kbd "<up>") 'comint-previous-input)
    (define-key shell-mode-map (kbd "<down>") 'comint-next-input))
  )

(message "Python")
(use-package python-mode
  :ensure t
  :config
  (global-eldoc-mode -1)
  (py-underscore-word-syntax-p-off)

  (define-key python-mode-map (kbd "<tab>") 'python-indent-shift-right)
  (define-key python-mode-map (kbd "<backtab>") 'python-indent-shift-left)
  
(add-hook 'python-mode-hook
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  )
)

;; pip install isort
;; https://github.com/timothycrosley/isort
;; ~/.isort.cfg
;; [settings]
;; multi_line_output=4
(use-package py-isort
  :ensure t
  :config
  (global-set-key (kbd "C-c o") 'py-isort-buffer)
  )

;; sudo apt install virtualenv
;; pip install virtualenvwrapper
;; source /usr/local/bin/virtualenvwrapper.sh
;; Add this to your .bashrc / .bash_profile / .zshrc:
;; # load virtualenvwrapper for python (after custom PATHs)
;; source /home/user/.local/bin/virtualenvwrapper.sh
;; ~/.local/bin/virtualenvwrapper.sh

;; VIRTUALENVWRAPPER_PYTHON="$(command \which python)"
;; sudo pip3 install virtualenv==20.0.23

;; mkvirtualenv env1
;; mkvirtualenv --python=python3.7 py3
;; pip install 'python-language-server[all]'

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-projectile-auto-workon)

  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell) ;; if you want eshell support
  ;; note that setting `venv-location` is not necessary if you
  ;; use the default location (`~/.virtualenvs`), or if the
  ;; the environment variable `WORKON_HOME` points to the right place
  (setq venv-location "~/.virtualenvs/")
  (global-set-key (kbd "C-c a") 'venv-workon)
  )

;; (use-package eglot
;;   :quelpa (eglot :fetcher github :repo "joaotavora/eglot")
;;   :ensure t
;;   :config
;;   (add-hook 'python-mode-hook 'eglot-ensure)
;;   (add-to-list 'eglot-server-programs
;;              `(python-mode . ("pyls" "-v" "--tcp" "--host"
;;                               "localhost" "--port" :autoport)))
;;   )

;; (use-package company-jedi
;;   :ensure t
;;   :config
;;   (defun my/ropemacs-mode-hook ()
;;     (add-to-list 'company-backends 'company-jedi))
;; 
;;   (add-hook 'ropemacs-mode-hook 'my/ropemacs-mode-hook)
;;   
;;   ;; (add-hook 'ropemacs-mode-hook 'jedi:setup)
;;   (setq jedi:complete-on-dot t)
;;   
;;   (define-key jedi-mode-map (kbd "C-o") 'jedi:goto-definition)
;;   ;; (define-key jedi-mode-map (kbd "<tab>") 'jedi:complete)
;;   (define-key jedi-mode-map (kbd "C-i") 'jedi:show-doc-in-tip)
;; 
;;   (add-hook 'jedi-mode-hook 'jedi-direx:setup)
;;   (add-hook 'ropemacs-mode-hook 'auto-complete-mode)
;;   (add-hook 'ropemacs-mode-hook 'jedi:ac-setup)
;;   (setq elpy-rpc-backend "jedi")
;;   (eval-after-load 'ropemacs-mode-hook
;;     '(define-key jedi-mode-map (kbd "TAB") 'jedi:complete))
;;   
;;   (setq jedi:server-args
;;       '("--virtual-env" "~/.virtualenvs/gc"
;;      ))
;;   )

(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)

  (define-key python-mode-map (kbd "C-o") 'anaconda-mode-find-definitions)
  (define-key python-mode-map (kbd "C-i") 'anaconda-mode-show-doc)
  ;; (define-key python-mode-map (kbd "<tab>") 'anaconda-mode-complete)

  (load-file (concat settings_path "settings/anaconda-settings.el"))
  )

(use-package company-anaconda
  :quelpa (company-anaconda :fetcher github :repo "pythonic-emacs/company-anaconda")
  :ensure t
  :config
  (eval-after-load "company"
    '(add-to-list 'company-backends 'company-anaconda))
  )

;; Requires pyflakes to be installed.
;; This requires pyflakes to be on PATH. Alternatively, set pyimport-pyflakes-path.
(use-package pyimport
  :ensure t
  :config
  ;; (define-key python-mode-map (kbd "C-x o") 'pyimport-insert-missing)
  (define-key python-mode-map (kbd "C-x i") 'pyimport-remove-unused)
  )

;; (use-package omnisharp
;;   :ensure t
;;   :config
;;   (add-hook 'csharp-mode-hook 'omnisharp-mode)
;;   (eval-after-load
;;     'company
;;     '(add-to-list 'company-backends #'company-omnisharp))
;; 
;;   (defun my-csharp-mode-setup ()
;;     (omnisharp-mode)
;;     (company-mode)
;;     (flycheck-mode)
;; 
;;     (setq indent-tabs-mode nil)
;;     (setq c-syntactic-indentation t)
;;     (c-set-style "ellemtel")
;;     (setq c-basic-offset 4)
;;     (setq truncate-lines t)
;;     (setq tab-width 4)
;;     (setq evil-shift-width 4)
;; 
;;     ;csharp-mode README.md recommends this too
;;     ;(electric-pair-mode 1)       ;; Emacs 24
;;     ;(electric-pair-local-mode 1) ;; Emacs 25
;; 
;;     (define-key omnisharp-mode-map (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
;;     (define-key omnisharp-mode-map (kbd "C-c s") 'omnisharp-start-omnisharp-server)
;;     (define-key omnisharp-mode-map (kbd "C-c C-c") 'recompile))
;;     (define-key omnisharp-mode-map (kbd "C-o") 'omnisharp-go-to-definition)
;;     (define-key omnisharp-mode-map (kbd "C-i") 'omnisharp-current-type-documentation)
;;     ;; (define-key omnisharp-mode-map (kbd "<tab>") 'omnisharp-auto-complete)
;;     )

(use-package js-auto-beautify
  :ensure t
  :config
  (add-hook 'js2-mode-hook 'js-auto-beautify-mode)
  )

;; pip install flake8
;; (use-package flymake-python-pyflakes
;;   :ensure t
;;   :config
;;   (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
;;   ;; (setq flymake-python-pyflakes-executable "flake8")
;;   (setq flymake-python-pyflakes-extra-arguments '("--ignore=C0111"))
;;   )

;; (use-package tabbar
;;   :ensure t
;;   :config (tabbar-mode)
;;   )
;; 
;; (message "Init tabbar-ruler")
;; (use-package tabbar-ruler
;;   :ensure t
;;   ;; :quelpa (tabbar-ruler :fetcher github :repo "mattfidler/tabbar-ruler.el")
;;   :config
;;   (setq tabbar-ruler-global-tabbar t) ; If you want tabbar
;;   (setq tabbar-ruler-global-ruler nil) ; if you want a global ruler
;;   ;; (setq tabbar-ruler-popup-menu t) ; If you want a popup menu.
;;   ;; (setq tabbar-ruler-popup-toolbar t) ; If you want a popup toolbar
;;   ;; (setq tabbar-ruler-popup-scrollbar t) ; If you want to only show the
;;   (tabbar-ruler-group-by-projectile-project)
;;   (tabbar-ruler-group-buffer-groups)
;; 
;;  (global-set-key (kbd "<C-M-tab>") 'tabbar-forward)
;;  (global-set-key (kbd "<C-M-iso-lefttab>") 'tabbar-backward)
;; 
;;  (global-set-key (kbd "C-x <C-tab>") 'tabbar-forward)
;;  (global-set-key (kbd "C-x <C-S-tab>") 'tabbar-backward)
;;  
;;  (setq tabbar-ruler-excluded-buffers
;;        (quote
;;         ("*Messages*" "*Completions*" "*ESS*" "*Packages*" "*log-edit-files*" "*helm-mini*" "*helm-mode-describe-variable*" "*anaconda-mode*" "*Anaconda*" "*Compile-Log*" "*grep*" "*pyls*" "*pyls::stderr*" "*rls*" "*rls::stderr*" "*eglot*" "*EGLOT*" "magit*")))
;;  )

(message "Init centaur-tabs")
(use-package centaur-tabs
  :ensure t
  :quelpa (centaur-tabs :fetcher github :repo "ema2159/centaur-tabs")
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style "chamfer")
  (setq centaur-tabs-height 20)
  (setq centaur-tabs-set-icons nil)
  (setq centaur-tabs-gray-out-icons 'buffer)

  (centaur-tabs-enable-buffer-reordering)
  (setq centaur-tabs-adjust-buffer-order t)

  ;; (centaur-tabs-group-by-projectile-project)
  
  (global-set-key (kbd "<C-M-tab>") 'centaur-tabs-forward)
  (global-set-key (kbd "<C-M-iso-lefttab>") 'centaur-tabs-backward)

  (defun centaur-tabs-buffer-groups ()
    (list
     (cond
      ((memq major-mode '(
                          magit-process-mode magit-status-mode
                          magit-diff-mode magit-log-mode
                          magit-file-mode magit-blob-mode
                          magit-blame-mode))
       "Emacs")
      ((derived-mode-p 'emacs-lisp-mode) "Lisp")
      ((derived-mode-p 'shell-mode) "Shell")
      ((derived-mode-p 'eshell-mode) "Shell")
      ((derived-mode-p 'aweshell-mode) "Shell")
      ((derived-mode-p 'python-mode) "Python")
      ((derived-mode-p 'web-mode) "Web")
      ((memq major-mode '(
                          org-mode org-agenda-clockreport-mode
                          org-src-mode org-agenda-mode
                          org-beamer-mode org-indent-mode
                          org-bullets-mode org-cdlatex-mode
                          org-agenda-log-mode diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  (defun centaur-tabs-hide-tab (x)
    (let ((name (format "%s" x)))
      (or
       (string-prefix-p "*epc" name)
       (string-prefix-p "*vc" name)
       (string-prefix-p "*helm" name)
       (string-prefix-p "*Compile-Log*" name)
       (string-prefix-p "*lsp" name)
       (and (string-prefix-p "magit" name)
            (not (file-name-extension name)))
       )))
  (centaur-tabs-group-buffer-groups)
  )

;; (use-package pdf-tools
;;   :ensure t)

(message "Init undo-tree")
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  )

;; (use-package multi-web-mode
;;   :ensure t
;;   :config
;;   (setq mweb-default-major-mode 'html-mode)
;;   (setq mweb-tags 
;;      '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;        (js-mode  "<script[^>]*>" "</script>")
;;        (css-mode "<style[^>]*>" "</style>")))
;;   (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;;   (multi-web-global-mode 1))

;; (use-package skewer-mode
;;   :ensure t
;;   :config
;;   (add-hook 'js2-mode-hook 'skewer-mode)
;;   (add-hook 'css-mode-hook 'skewer-css-mode)
;;   (add-hook 'html-mode-hook 'skewer-html-mode))

(use-package swiper
  :ensure t)

(use-package atomic-chrome
  :ensure t
  :config
  (atomic-chrome-start-server))

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

(use-package which-key
  ;; displays available keybindings in popup
  :ensure t
  :config
  (which-key-mode)
  )

;; Let Emacs move the cursor off-screen
(use-package scroll-restore
  :ensure t
  :config
  (setq scroll-restore-mode 1))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t) ;; or doom-dark, etc.
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)  ; all-the-icons fonts must be installed
  ;; (doom-themes-org-config)
  )

(use-package fancy-battery
  :ensure t
  )

;; Doesnt work with emacs 27
(use-package doom-modeline
  :ensure t
  :quelpa (doom-modeline :fetcher github :repo "seagle0128/doom-modeline")
  :config
  (doom-modeline-mode 1)
  )

;; M-x customize-face RET auto-dim-other-buffers-face RET #333843
;;(use-package auto-dim-other-buffers
;;  :config
;;  (auto-dim-other-buffers-mode t)
;;  )

;; Since I just was bitten by this. Installation of the fonts is as simple as:
;; $ git clone https://github.com/domtronn/all-the-icons.el.git
;; $ install -m 0644 -D all-the-icons.el/fonts/*.ttf -t ~/.local/share/fonts/
(use-package all-the-icons
  :ensure t
  :init
  (if (string-equal system-type "windows-nt")
      (setq font-dest "C:\\Windows\\Fonts")
      (unless (member "all-the-icons" (font-family-list))
        (all-the-icons-install-fonts t))
  )
  :config
  (all-the-icons-octicon "file-binary")
  )

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup)
  )

;; (use-package dashboard
;;   :ensure t
;;   :config
;;   (dashboard-setup-startup-hook)
;;   )

;;(use-package solaire-mode
;;  :ensure t
;;  :config
;;  ;; brighten buffers (that represent real files)
;;  (add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)
;;  ;; To enable solaire-mode unconditionally for certain modes:
;;  (add-hook 'ediff-prepare-buffer-hook #'solaire-mode)
;;
;;  ;; ...if you use auto-revert-mode, this prevents solaire-mode from turning
;;  ;; itself off every time Emacs reverts the file
;;  (add-hook 'after-revert-hook #'turn-on-solaire-mode)
;;
;;  ;; highlight the minibuffer when it is activated:
;;  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)
;;
;;  ;; if the bright and dark background colors are the wrong way around, use this
;;  ;; to switch the backgrounds of the `default` and `solaire-default-face` faces.
;;  ;; This should be used *after* you load the active theme!
;;  ;;
;;  ;; NOTE: This is necessary for themes in the doom-themes package!
;;  (solaire-mode-swap-bg)
;;  )

;; (use-package linum-relative
;;   :ensure t
;;   :config
;;   (global-set-key (kbd "C-x i") 'linum-relative-toggle))


;; automatic and manual symbol highlighting for Emacs
(use-package highlight-symbol
  :ensure t
  :config
  (setq highlight-symbol-idle-delay 0)
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  (add-hook 'text-mode-hook 'highlight-symbol-mode)
  (global-unset-key (kbd "C-q"))
  (global-set-key [(control f3)] 'highlight-symbol)
  (global-set-key (kbd "C-q") 'highlight-symbol-next)
  (global-set-key (kbd "C-S-q") 'highlight-symbol-prev)
  (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
  )

(use-package right-click-context
  :ensure t
  :quelpa (right-click-context :fetcher github :repo "zonuexe/right-click-context")
  :config
  (right-click-context-mode 1)
  )

(use-package org
  :ensure t
  :config
  ;; (setq org-log-done 'time)

  (define-key org-mode-map (kbd "C-c l") 'org-scontexttore-link)
  (define-key org-mode-map (kbd "C-h") 'delete-backward-char)
  (define-key org-mode-map (kbd "M-h") 'backward-delete-word)

  (define-key org-mode-map (kbd "C-c a") 'org-clock-in)
  (define-key org-mode-map (kbd "C-c e") 'org-clock-out)
  (define-key org-mode-map (kbd "C-c c") 'org-clock-in-last)

  (define-key org-mode-map (kbd "C-i") 'org-shiftright)
  (define-key org-mode-map (kbd "C-S-i") 'org-shiftleft)

  (define-key org-mode-map (kbd "C-o") 'org-metaright)
  (define-key org-mode-map (kbd "C-S-o") 'org-metaleft)

  (define-key org-mode-map (kbd "<C-tab>") (lambda () (interactive) (other-window 1)))
  (define-key org-mode-map (kbd "<C-iso-lefttab>") (lambda () (interactive) (other-window -1)))

  (setq org-todo-keywords
        '((sequence "TODO" "IN" "|" "DONE")))
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "dodger blue" :weight bold))
          ("IN" . (:foreground "lawn green" :weight bold))
          ("DONE" . (:foreground "dim gray" :weight bold))
          ))

  (setq org-agenda-files (list (concat dropbox_path "org_files")))
  (global-set-key (kbd "C-x n !") (lambda() (interactive)(find-file (concat dropbox_path "org_files/main.org"))))
  (global-set-key (kbd "C-x n @") (lambda() (interactive)(find-file (concat dropbox_path "org_files/work.org"))))
  (custom-set-faces '(org-link ((t (:underline "dodger blue" :foreground "dodger blue")))))
  (add-hook 'org-mode-hook #'(lambda ()
                               (visual-line-mode)
                               (org-indent-mode)))
  )

(use-package org-super-agenda
  :ensure t
  :quelpa (org-super-agenda :fetcher github :repo "alphapapa/org-super-agenda")
  :config
  (org-super-agenda-mode)
  )

;;(use-package workgroups2
;;  :ensure t
;;  :config
;;  (setq wg-session-file (concat settings_path "emacsd/.emacs_workgroups"))
;;  (workgroups-mode 1)
;;  (setq wg-emacs-exit-save-behavior           'save)      ; Options: 'save 'ask nil
;;  (setq wg-workgroups-mode-exit-save-behavior 'save)      ; Options: 'save 'ask nil
;;
;;  ;; Set your own keyboard shortcuts to reload/save/switch WGs:
;;  ;; "s" == "Super" or "Win"-key, "S" == Shift, "C" == Control
;;  (global-set-key (kbd "<pause>") 'wg-reload-session)
;;  (global-set-key (kbd "C-S-<pause>") 'wg-save-session)
;;  (global-set-key (kbd "s-z") 'wg-switch-to-workgroup)
;;  (global-set-key (kbd "s-\\") 'wg-switch-to-previous-workgroup)
;;  )

;; Charging isplay
;; (add-hook 'after-init-hook #'fancy-battery-mode)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Make sure that your Emacs was compiled with module support.
;; Check that module-file-suffix is not nil

(message "Load functions.el")
(load-file (concat settings_path "settings/functions.el"))

;; (message "Init so libs")
;; (message module-file-suffix)
;; (if module-file-suffix
;;     (if (string-suffix-p module-file-suffix ".so")
;;         (progn (message module-file-suffix)
;;                
;;                (load (concat settings_path "parsers/target/debug/libparserslib.so"))
;;                (load-file (concat settings_path "settings/menu.el"))
;; 
;;                (global-set-key (kbd "C-x n f") 'frelansim-links)
;;                ))
;;   (message "module-file-suffix is nil")
;;   )

(define-key lisp-mode-map (kbd "C-i") 'describe-function-in-popup)

(message "Read desktop")
(call-interactively 'desktop-read t (vector "~/.emacs-save/" t))
(message "End main.py")
