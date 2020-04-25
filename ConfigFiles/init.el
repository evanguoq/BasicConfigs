;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(file-name-shadow-mode nil)
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (all-the-icons-ibuffer all-the-icons-ivy use-package monokai-theme counsel all-the-icons ag))))

;; Default font
(add-to-list 'default-frame-alist '(font . "Hack-10"))

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

;; This is only needed once, near the top of the file
(require 'use-package)

(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(require 'evil)
(evil-mode 1)
(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))
;; Hide all buffers starting with an asterisk 
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")

(require 'all-the-icons)
(require 'all-the-icons-ivy)
(require 'all-the-icons-ibuffer)

;; C programming settings
(defun tait-c-mode-common-hook ()
 ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
 (c-set-offset 'substatement-open 0)
 (c-set-offset 'case-label '+)
 ;; other customizations can go here

 (setq c++-tab-always-indent t)
 (setq c-basic-offset 3)                  ;; Default is 2
 (setq c-indent-level 3)                  ;; Default is 2
 (setq tab-width 3)
 (setq indent-tabs-mode t)  ; use spaces only if nil
 )
(add-hook 'c-mode-common-hook 'tait-c-mode-common-hook)
(add-hook 'c++-mode-common-hook 'tait-c-mode-common-hook)

;; Syntacs scheme
(load-theme 'monokai t)

;; Open files side by side as default
(setq split-height-threshold nil) 
(setq split-width-threshold 0) 

;; Ivy and Counsel settings
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;;(setq search-default-mode #'char-fold-to-regexp)
;;(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; Start server at start up
(server-start)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; No back-up files please!
(setq make-backup-files nil)
