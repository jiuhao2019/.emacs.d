;;———————————————————————————————————————————————proxy
(setq url-proxy-services
      '(("http" . "127.0.0.1:7890")
        ("https" . "127.0.0.1:7890")))
        ;;———————————————————————————————————————————————end proxy

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory)) ; 设定源码加载路径
(add-to-list 'load-path (expand-file-name "package" user-emacs-directory)) ; 设定源码加载路径
(add-to-list 'load-path (expand-file-name "package" user-emacs-directory)) ; 设定源码加载路径

;;———————————————————————————————————————————————strait.el
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

;; do not steal focus while doing async compilations
(setq warning-suppress-types '((comp)))
;;———————————————————————————————————————————————end strait.el

(setopt ;; initial-major-mode 'fundamental-mode
 inhibit-startup-screen t
 ;; (setq ring-bell-function 'ignore)
 ring-bell-function (lambda ()
                      (invert-face 'mode-line)
                      (run-with-timer 0.05 nil 'invert-face 'mode-line))
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

(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar
(column-number-mode 1)
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
      kept-old-versions 3               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 3               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 30              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 300)            ; number of keystrokes between auto-saves (default: 300)

;; 把 Emacs 自动添加的代码放到 custom.el
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
;; Font setting.
;; `set-face-attribute' 设置默认字体
;; 对于中英文字体无法做到等宽和等高，两者只能取其一。相对而言，等宽更重要一些。
;; 不等高会导致 modeline 跳动，可以在 modeline 中插入中文字体“丨”[gun]
;; 字体搭配1: Cascadia Next SC
;; 字体搭配2: Latin Modern Mono 和 Source Han Serif SC
(set-face-attribute 'default nil :family "Fira Code Nerd Font Mono" :height 108)

;; Unicode
;; `set-fontset-font' 用于指定某些字符集使用特定的字体
(set-fontset-font t 'unicode (font-spec :family "Fira Code Nerd Font Mono" :size 14) nil 'prepend)

;; 设置中文字集
;; `han': 汉字字符集，主要用于简体中文和繁体中文字符
;; `cjk-misc': CJK（中日韩）字符集中的其他字符，包含了少量的中文、日文、韩文字符
;; `kana': 日文假名字符集，但在处理与中文相关的文档时可能偶尔用到
;; `bopomofo': 注音符号字符集，用于台湾地区的汉字注音
(dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family "Noto Sans CJK SC")))

;; Emoji
;; According to https://github.com/domtronn/all-the-icons.el
;; Use 'prepend for the NS and Mac ports or Emacs will crash.
(set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji" :size 14) nil 'prepend)
(set-fontset-font t 'symbol (font-spec :family "Fira Code Nerd Font Mono" :size 14) nil 'prepend)

;; 除以上方法，也可以使用 `variable-pitch-mode'
;; (set-face-attribute 'variable-pitch nil :family "TsangerJinKai02" :height 160)
;; (set-face-attribute 'fixed-pitch nil :family "SF Mono" :height 160)
;; (add-hook 'text-mode-hook #'variable-pitch-mode)
;;———————————————————————————————————————————————end font


;;———————————————————————————————————————————————plugin
(require 'on);;控制插件什么时候加载

(require 'ialign)
(global-set-key (kbd "C-x l") #'ialign)
;;———————————————————————————————————————————————gcmh
;; Better emacs garbage collect behavior
(use-package gcmh
  :hook (on-first-buffer . gcmh-mode)
  :custom
  (gc-cons-percentage 0.1)
  (gcmh-verbose nil)
  (gcmh-idle-delay 'auto)
  (gcmh-auto-idle-delay-factor 10)
  (gcmh-high-cons-threshold #x1000000))

(advice-add 'after-focus-change-function :after 'garbage-collect)
;;———————————————————————————————————————————————end gcmh
(defun switch-to-message ()
  "Quick switch to `*Message*' buffer."
  (interactive)
  (switch-to-buffer "*Messages*"))
(global-set-key (kbd "M-g m") #'switch-to-message)
(global-set-key (kbd "M-g s") #'scratch-buffer)
;;
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
(require 'user-dashboard)
(require 'user-rg)
(require 'user-pdf-tool)
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
(setq recentf-max-saved-items 1000)
(recentf-mode 1)

;;使能加密
(require 'epa-file)
(epa-file-enable)

;;可以给标题级别内容的加密
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote("crypt")))
(setq org-crypt-key nil);;密钥加密(非对称加密)或密码加密(对称加密)

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

(use-package ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(use-package imenu)

;;Whenever the window scrolls a light will shine on top of your cursor so you know where it is.
(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  (setq beacon-push-mark 35
        beacon-blink-when-focused t
        beacon-color "deep sky blue"))

(use-package define-word
  :ensure t)

(use-package google-translate
  :ensure t
  :commands google-translate-smooth-translate
  :init
  (setq-default google-translate-translation-directions-alist
                '(("cn" . "en") ("en" . "cn"))
                google-translate-show-phonetic t))

(use-package lua-mode
  :ensure t
  :mode ("\\.lua\\'" . lua-mode)
  :interpreter ("lua" . lua-mode))

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package pretty-mode
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'turn-on-pretty-mode))

(use-package ztree
  :config
  (set-face-attribute 'ztreep-diff-model-add-face  nil :foreground "deep sky blue")
  (setq ztree-draw-unicode-lines t)
  (bind-keys :map ztreediff-mode-map
             ("p" . previous-line)
             ("k" . previous-line)
             ("j" . next-line)
             ("n" . next-line)))

;;———————————————————————————————————————————————
;;put this at end of plugin
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :hook (on-first-input . which-key-mode)
  :config (setq which-key-idle-delay 0))
(which-key-mode)
(require 'user-keybind)
;;———————————————————————————————————————————————end plugin
;; 这段代码放在最后, 加载 Emacs 自动设置的变量
(if (file-exists-p custom-file) (load-file custom-file))
