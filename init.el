 ;; My functions

(defun my-keymap-global-set (key symbol)
  "Globally bind KEY to the data inside SYMBOL,
if KEY is not already bound to another symbol."
  (unless (keymap-lookup nil key)
    (keymap-global-set key symbol)))


;; Error handling
(when (string-equal emacs-version "29.1")
       (with-current-buffer
           (url-retrieve-synchronously
            "https://git.savannah.gnu.org/cgit/emacs.git/plain/lisp/emacs-lisp/loaddefs-gen.el?h=emacs-29")
         (goto-char (point-min))
         (while (looking-at "^.+$") (forward-line))
         (eval-region (point) (point-max))))


;; Package-management

;; ADD repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/") t)

;; Initialize packages
(package-initialize)
(set 'package-install-upgrade-built-in t)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Configure use-package to always ensure packages are installed
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Install pdf-tools
(unless (package-installed-p 'pdf-tools)
  (package-refresh-contents)
  (package-install 'pdf-tools))

;; Install tramp
(unless (package-installed-p 'tramp)
  (package-refresh-contents)
  (package-install 'tramp))

;; Install magit
(unless (package-installed-p 'magit)
  (package-refresh-contents)
  (package-install 'magit))

;; Trying to fix an error
(use-package tramp)
(use-package magit)

;; Install org mode
(unless (package-installed-p 'org)
  (package-refresh-contents)
  (package-install 'org))

;; General configurations

;; Configure mode-line
(display-time-mode 1)

;; Disable gui-elements
(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; Move customization variables to a separate file and load it
(set 'custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Displaying of line-numbers Older emacs versions
;; (line-number-mode 0)
;;(use-package nlinum
;;  :ensure t
;;  :config
;;  (setq nlinum-format "%4d")
;;  (global-nlinum-mode t))
;; (use-package linum-relative
;;  :ensure t
;;  :config
;;  (linum-relative-global-mode)
;;  (setq linum-relative-current-symbol ""))

;; Displaying of line-numbers
(set 'display-line-numbers-type 'relative)
(global-display-line-numbers-mode)


;; Org-mode config

;; When nil, no confirmation is asked when executing Babel code-blocks
(set 'org-confirm-babel-evaluate nil)

;; General skeleton for org-babel
(define-skeleton org-my-skeleton
  "Headers for org-babel blocks."
  "#+TITLE: \n"
  "#+AUTHOR: YxNiI \n"
  "#+INFOJS_OPT: \n"
  "#+BABEL: :session *elisp* :cache yes :results output graphics :exports both :tangle yes \n")

;; Bind org-babel skeleton to key
(keymap-global-set "C-c s i" 'org-my-skeleton)
