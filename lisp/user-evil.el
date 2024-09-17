;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  ;;默认从插入模式返回后会自动退一个位置，禁用此默认
  (setq evil-move-cursor-back nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))


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

;;显示最大column位置
(use-package fill-column-indicator)
(add-hook 'text-mode-hook (lambda ()
                          (turn-on-auto-fill)
                          (fci-mode)
                          (set-fill-column 82)))

(provide 'user-evil)
