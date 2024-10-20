(use-package pyim)
(use-package pyim-basedict)
(require 'pyim-cregexp-utils)

;; 使用 popup
(use-package popon)
(setq pyim-page-tooltip 'popon)

;; 加载 basedict 拼音词库。
(pyim-basedict-enable)

;; 将 Emacs 默认输入法设置为 pyim.
(setq default-input-method "pyim")
(global-set-key (kbd "C-\\") 'toggle-input-method)

;; 显示 5 个候选词。
(setq pyim-page-length 5)

;; 设置 pyim 默认使用的输入法策略。
(pyim-default-scheme 'quanpin)


(provide 'user-pyim)
