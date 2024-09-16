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

;; 把 Emacs 自动添加的代码放到 custom.el
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
(require 'user-func)
(require 'user-org)
(require 'user-neotree)
(require 'user-lsp)
(require 'user-lisp-format)
(require 'user-valign)

(use-package amx ;;auto show recent commands
  :init (amx-mode))

(use-package undo-tree ;;Cx u
  :defer t
  :diminish undo-tree-mode
  :init (global-undo-tree-mode)
  :custom (undo-tree-visualizer-diff t)
  (undo-tree-history-directory-alist '(("." . "~/undo-emacs")))
  (undo-tree-visualizer-timestamps t))

(use-package avy ;; easymotion
  :config (setq avy-background t ;; 打关键字时给匹配结果加一个灰背景，更醒目
                avy-all-windows t ;; 搜索所有 window，即所有「可视范围」
                avy-timeout-seconds 0.3)) ;; 「关键字输入完毕」信号的触发时间

(use-package highlight-symbol
  :init (highlight-symbol-mode))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0))
(which-key-mode)

(require 'user-keybind)

(use-package dogears ;;记录光标位置列表
  :hook (after-init . dogears-mode)
  :bind (:map global-map ("M-g g" . dogears-go)
              ("M-g b" . dogears-back)
              ("M-g f" . dogears-forward)
              ("M-g l" . dogears-list)
              ("M-g M-s" . dogears-sidebar))
  :config (setq dogears-idle 1 dogears-limit 200 dogears-position-delta 20)
  (setq dogears-functions '(find-file recenter-top-bottom other-window switch-to-buffer aw-select toggle-window-split windmove-do-window-select pager-page-down pager-page-up tab-bar-select-tab pop-to-mark-command pop-global-mark goto-last-change xref-go-back xref-find-definitions xref-find-references)))

(use-package vertico ;; 竖式展开小缓冲区
  :custom (verticle-cycle t)
  :config (vertico-mode))

(use-package marginalia ;; 更多信息
  :config (marginalia-mode))

(use-package orderless ;; 乱序补全
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;;; recently opened file
(require 'recentf)
(setq recentf-max-saved-items 100)
(recentf-mode 1)

;;使能加密
(require 'epa-file)
(epa-file-enable)

;;可以标题级别的加密
;; (require 'org-crypt)
;; (org-crypt-use-before-save-magic)
;; (setq org-tags-exclude-from-inheritance (quote("crypt")))
;; (setq org-crypt-key nil)
;;====================================================================================
;; 这段代码放在最后, 加载 Emacs 自动设置的变量
(if (file-exists-p custom-file) (load-file custom-file))
