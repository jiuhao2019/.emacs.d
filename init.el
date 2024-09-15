(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar
(column-number-mode 1)
(setq visible-bell t)       ; Set up the visible bell

(set-face-attribute 'default nil :font "Fira Code Nerd Font Mono" :height 178 :weight 'regular)
(set-face-attribute 'fixed-pitch nil :font "Fira Code Nerd Font Mono" :height 178 :weight 'regular)
(set-face-attribute 'variable-pitch nil :font "Fira Code Nerd Font Mono" :height 178 :weight 'regular)

;;put auto-backup-file all to one folder
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))

(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 3               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 3               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 30              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 300)            ; number of keystrokes between auto-saves (default: 300)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory)) ; 设定源码加载路径

(setq url-proxy-services
      '(("http" . "127.0.0.1:7890")
	    ("https" . "127.0.0.1:7890")))

;; 把 Emacs 自动添加的代码放到 custom.el 中
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;strait.el
(defvar bootstrap-version)
(let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 7))
      (unless (file-exists-p bootstrap-file)
        (with-current-buffer
        (url-retrieve-synchronously "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el" 'silent 'inhibit-cookies)
        (goto-char (point-max)) (eval-print-last-sexp)))
      (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package) ; 用 straight.el 安装 use-package 声明的插件
(setq straight-use-package-by-default t) ; 自动安装所有插件, 相当于加入 :straight t
(setq use-package-compute-statistics t)
;; performance
;; https://emacs-lsp.github.io/lsp-mode/page/performance/
(setq gc-cons-threshold 100000000
      read-process-output-max (* 1024 1024))
;; do not steal focus while doing async compilations
(setq warning-suppress-types '((comp)))
;;end strait.el

;;====================================================================================
(require 'user-theme)
(setq evil-want-C-u-scroll t)
(require 'user-evil)
(require 'user-ivy)
(require 'user-org)
(require 'user-neotree)
(require 'user-lsp)
;;====================================================================================

;; 这段代码放在最后, 加载 Emacs 自动设置的变量
(if (file-exists-p custom-file) (load-file custom-file))
