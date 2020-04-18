;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (all-the-icons powerline-evil badwolf-theme airline-themes centaur-tabs helm exec-path-from-shell evil ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'default-frame-alist '(font . "Hack-16"))

(require 'evil)
(evil-mode 1)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'all-the-icons)
(all-the-icons-ivy-setup)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
(setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
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

;; This is only needed once, near the top of the file
(require 'use-package)

(global-set-key (kbd "C-]") nil)
(global-set-key (kbd "C-t") nil)
(dumb-jump-mode)
(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-]" . dumb-jump-go)
         ("M-t" . dumb-jump-back)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
  :ensure)

(require 'centaur-tabs)
(centaur-tabs-mode t)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-set-modified-marker t)
(setq centaur-tabs-modified-marker "*")
(define-key evil-normal-state-map (kbd "<tab>") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "<S-tab>") 'centaur-tabs-backward)
(setq centaur-tabs-cycle-scope 'tabs)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 3)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

(require 'powerline)
(powerline-default-theme)
;;(powerline-center-evil-theme)
;;(powerline-vim-theme)

(load-theme 'badwolf t)
(require 'powerline-evil)

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))
