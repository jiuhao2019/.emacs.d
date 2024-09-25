(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l"
	lsp-file-watch-threshold 500)
  (setq lsp-clients-clangd-executable "ccls"
	lsp-clients-clangd-args nil)
  :hook 
  (lsp-mode . lsp-enable-which-key-integration) ; which-key integration
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-completion-provider :none) ;; 阻止 lsp 重新设置 company-backend 而覆盖我们 yasnippet 的设置
  (setq lsp-headerline-breadcrumb-enable t)
  :bind
  ("C-c l s" . lsp-ivy-workspace-symbol)) ;; 可快速搜索工作区内的符号（类名、函数名、变量名等）

(use-package lsp-ui
   :config
   (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
   (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
   (setq lsp-ui-doc-position 'top))

(use-package lsp-ivy
   :after (lsp-mode))

(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉

(use-package company-box
   :ensure t
   :if window-system
   :hook (company-mode . company-box-mode))

(use-package yasnippet
   :ensure t
   :hook
   (prog-mode . yas-minor-mode)
   :config
   (yas-reload-all)
   ;; add company-yasnippet to company-backends
   (defun company-mode/backend-with-yas (backend)
     (if (and (listp backend) (member 'company-yasnippet backend))
        backend
     (append (if (consp backend) backend (list backend))
     '(:with company-yasnippet))))
     (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
       ;; unbind <TAB> completion
       (define-key yas-minor-mode-map [(tab)]        nil)
       (define-key yas-minor-mode-map (kbd "TAB")    nil)
       (define-key yas-minor-mode-map (kbd "<tab>")  nil)
   :bind
   (:map yas-minor-mode-map ("S-<tab>" . yas-expand)))
                   
(use-package yasnippet-snippets
   :ensure t
   :after yasnippet)

(use-package projectile
   :diminish projectile-mode
   :config
   (projectile-mode)
   (setq projectile-mode-line "Projectile")
   (setq projectile-track-known-projects-automatically nil)
   :custom ((projectile-completion-system 'ivy))
   :bind-keymap
   ("C-c p" . projectile-command-map))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))


(provide 'user-lsp)
