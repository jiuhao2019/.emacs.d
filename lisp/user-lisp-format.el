;;C-c C-q   (先光标放在一个模块里的首括号上,然后快捷键格式化)
(use-package aggressive-indent )

(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)

(provide 'user-lisp-format)

