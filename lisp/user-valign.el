(use-package valign
  :config
  (setq valign-max-table-size 7000)
  (setq valign-fancy-bar t))
;;用的时候再使能
;; (add-hook 'org-mode-hook #'valign-mode)

(provide 'user-valign)

