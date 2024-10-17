;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  ;;默认从插入模式返回后会自动退一个位置，禁用此默认
  (setq evil-move-cursor-back nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter)

(use-package evil-surround
  :init (global-evil-surround-mode))

;;光标在边沿位置移动不再自动跳半个屏幕
(use-package smooth-scrolling
  :config
  (setq scroll-margin 5
        scroll-conservatively 9999
        scroll-step 1))

(provide 'user-evil)
