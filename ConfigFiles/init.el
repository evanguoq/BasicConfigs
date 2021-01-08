;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (dumb-jump wgrep-ack exec-path-from-shell rg use-package org-bullets ivy evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; This is only needed once, near the top of the file
;; package: use-package
(require 'use-package)
(unless package-archive-contents
  (package-refresh-contents))

;; Default frame behaviours
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(font . "Hack-13"))

;; syntax scheme
;;(load-theme 'monokai t)

;; org mode
;; package: org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;; evil mode
;; package: evil
(require 'evil)
(evil-mode 1)
(with-eval-after-load 'evil
                      (defalias #'forward-evil-word #'forward-evil-symbol)
                      ;; make evil-search-word look for symbol rather than word boundaries
                      (setq-default evil-symbol-word-search t))

;; buffer management
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))
;; Hide all buffers starting with an asterisk 
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")
;; C code style
(defun tait-c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'case-label '+)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'brace-list-intro '+)

  (setq c++-tab-always-indent t)
  (setq c-basic-offset 3)    ;; Default is 2
  (setq c-indent-level 3)    ;; Default is 2
  (setq tab-width 3)
  (setq indent-tabs-mode t)  ; use spaces only if nil
  ;; NB: You can find the correct indentation identifier using C-c C-s
  ;; (c-show-syntactic-information) on any line of a C++ buffer. It will
  ;; perform the syntactic analysis of the line and display the results.
  )
(add-hook 'c-mode-common-hook 'tait-c-mode-common-hook)
(add-hook 'c++-mode-common-hook 'tait-c-mode-common-hook)

;; C++ Compiler key binding <F5>
(defun compileandrun()
  (interactive)
  (save-buffer)
  (compile (concat "g++ "  (file-name-nondirectory (buffer-file-name)) " -o " (file-name-sans-extension   (file-name-nondirectory (buffer-file-name))) " && ./" (file-name-sans-extension  (file-name-nondirectory (buffer-file-name)))) t )
  (other-window 1)
  (end-of-buffer)
  ) 
(add-hook 'c++-mode-hook
          (lambda () (local-set-key (kbd "<f5>") #'compileandrun)))

;; Open files side by side as default
(setq split-height-threshold nil) 
(setq split-width-threshold 0) 

;; package: ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; Start server at start-up
(server-start)

;; No back-up files required
(setq make-backup-files nil)

;; package: rg
(global-set-key [f4] 'rg-dwim-project-dir)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; package: dumb-jump
;; you can now use M-., Ctrl+] (or gd when using Evil).
(setq dumb-jump-force-searcher 'rg)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
