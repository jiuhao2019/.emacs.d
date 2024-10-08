(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory)) ; 设定源码加载路径
(add-to-list 'load-path (expand-file-name "package" user-emacs-directory)) ; 设定源码加载路径

(setopt
 inhibit-startup-screen t
 use-file-dialog nil
 use-dialog-box nil
 use-short-answers t
 read-process-output-max #x10000
 create-lockfiles nil
 recenter-redisplay nil
 next-screen-context-lines 5
 inhibit-compacting-font-caches t
 frame-resize-pixelwise t
 inhibit-quit nil
 fast-but-imprecise-scrolling t
 scroll-preserve-screen-position 'always
 auto-save-list-file-name nil
 history-length 1000
 history-delete-duplicates t
 bidi-display-reordering nil
 read-buffer-completion-ignore-case t
 completion-ignore-case t
 delete-by-moving-to-trash t
 minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt)
 redisplay-skip-fontification-on-input t
 cursor-in-non-selected-windows nil)

(setq-default initial-scratch-message nil)
(setq-default bidi-display-reordering nil)
;; Emacs "updates" its ui more often than it needs to, so slow it down slightly
(setq idle-update-delay 1.0)  ; default is 0.5
;;———————————————————————————————————————————————卡顿问题解决
;;如大文件卡顿，试此配置
;; (setq-default bidi-display-reordering nil)
;; (setq bidi-inhibit-bpa t
;;       long-line-threshold 1000
;;       large-hscroll-threshold 1000
;;       syntax-wholeline-max 1000)
;; ;;———————————————————————————————————————————————end卡顿问题解决

(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar
(column-number-mode -1)
(setq visible-bell t)       ; Set up the visible bell

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
      kept-old-versions 5               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 5               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 30              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 300)            ; number of keystrokes between auto-saves (default: 300)

(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

(defvar k-gc-timer
  (run-with-idle-timer 15 t
		       (lambda ()
                         (message "Garbage Collector has run for %.06fsec"
                                  (k-time (garbage-collect))))))


;; 把Emacs自动添加的代码放到 custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Language Environment
(set-language-environment "UTF-8")
(setq default-input-method nil)

;; System Coding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;;———————————————————————————————————————————————font
;;默认字体
(set-face-attribute 'default nil :family "Fira Code Nerd Font Mono" :height 175)

;; Unicode
;; `set-fontset-font' 用于指定某些字符集使用特定的字体
(set-fontset-font t 'unicode (font-spec :family "Fira Code Nerd Font Mono" :size 14) nil 'prepend)

;; 中文字集
;; `han': 汉字字符集，主要用于简体中文和繁体中文字符
;; `cjk-misc': CJK（中日韩）字符集中的其他字符，包含了少量的中文、日文、韩文字符
;; `kana': 日文假名字符集，但在处理与中文相关的文档时可能偶尔用到
;; `bopomofo': 注音符号字符集，用于台湾地区的汉字注音
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family "Noto Sans CJK SC")))

;; Emoji
;; According to https://github.com/domtronn/all-the-icons.el
(set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji" :size 14) nil 'prepend)
(set-fontset-font t 'symbol (font-spec :family "Fira Code Nerd Font Mono" :size 14) nil 'prepend)
;;———————————————————————————————————————————————end font
;;———————————————————————————————————————————————proxy
(setq url-proxy-services
      '(("http" . "127.0.0.1:7890")
        ("https" . "127.0.0.1:7890")))
;;———————————————————————————————————————————————end proxy
;;———————————————————————————————————————————————straight
(defvar bootstrap-version)
(let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el" 'silent 'inhibit-cookies)
      (goto-char (point-max)) (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package) ; 用 straight.el 安装 use-package
(setq straight-use-package-by-default t) ;;自动安装所有插件, 相当于加入 :straight t
(setq use-package-compute-statistics t)

(setq warning-suppress-types '((comp)))
;;———————————————————————————————————————————————end straight

;;———————————————————————————————————————————————plugin
(require 'on)
(require 'ialign)
(require 'user-theme)
(setq evil-want-C-u-scroll t)
(require 'user-evil)
(require 'user-ivy)
(require 'user-func)
(require 'user-org)
(require 'user-neotree)
(require 'user-lsp)
(require 'user-lisp-format)
(require 'user-valign);;能让表格里有中文的表格对齐,但是如打开的文件里表格多且大就卡顿。
(require 'user-rg)
(use-package amx ;;auto show recent commands
  :init (amx-mode))

(use-package undo-tree
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

(use-package marginalia ;; 更多信息
  :config (marginalia-mode))

(use-package orderless ;; 乱序补全
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;;; recently opened file
(use-package recentf
  :config
  (setq recentf-max-saved-items 1000)
  (recentf-mode 1))

;;使能加密
(require 'epa-file)
  (epa-file-enable)

;;让用户输入的密码不会因内存不足而换出到磁盘
(use-package pinentry
  :config
  (setq epa-pinentry-mode 'loopback)
  (pinentry-start))

(use-package fzf
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
	fzf/grep-command "rg --no-heading -nH"
        ;;fzf/grep-command "grep -nrH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))

(use-package nerd-icons-completion
  :hook (minibuffer-setup . nerd-icons-completion-mode))

(use-package ggtags )
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(use-package imenu )

(use-package google-translate
  :commands google-translate-smooth-translate
  :init
  (setq-default google-translate-translation-directions-alist
                '(("cn" . "en") ("en" . "cn"))
                google-translate-show-phonetic t))

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci")))))
;;移动字符块
(use-package drag-stuff
  :init (drag-stuff-global-mode))

;;文件浏览
(use-package dirvish
  :config (dirvish-override-dired-mode))

(use-package lua-mode)
(use-package markdown-mode)

;;折叠大括号块
(use-package hideshow
  :hook (prog-mode . hs-minor-mode)
  :custom
  (hs-special-modes-alist
   (mapcar 'purecopy
           '((c-mode "{" "}" "/[*/]" nil nil)
             (c++-mode "{" "}" "/[*/]" nil nil)
             (rust-mode "{" "}" "/[*/]" nil nil)))))

;;记住每个buffer离开时光标位置
(use-package saveplace
  :hook (after-init . save-place-mode))

;; A modern Packages Menu
(use-package paradox
  :init
  (setq paradox-execute-asynchronously t
        paradox-github-token t
        paradox-display-star-count nil)
  ;; Replace default `list-packages'
  (defun my-paradox-enable (&rest _)
    "Enable paradox, overriding the default package-menu."
    (paradox-enable))
  (advice-add #'list-packages :before #'my-paradox-enable))

;;———————————————————————————————————————————————
;;put this at end of plugin
(use-package which-key
  :config (setq which-key-idle-delay 0))
(which-key-mode)

(require 'user-keybind)
;;———————————————————————————————————————————————end plugin
;; 这段代码放在最后, 加载 Emacs 自动设置的变量
(if (file-exists-p custom-file) (load-file custom-file))
