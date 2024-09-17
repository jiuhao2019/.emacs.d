(use-package dashboard
  :demand t
  :hook (dashboard-mode . (lambda ()
                            (setq-local display-line-numbers nil)))
  :custom
  (dashboard-startup-banner (expand-file-name "src/bitmap.png" user-emacs-directory))
  (dashboard-image-banner-max-width 500)
  (dashboard-icon-type 'nerd-icons)
  (dashboard-set-file-icons t)
  (dashboard-center-content t)
  (dashboard-set-init-info t)
  (dashboard-week-agenda nil)
  (dashboard-set-footer nil)
  (dashboard-items '((recents  . 3)))
  (dashboard-banner-logo-title "EXPLORE THE WORLD, FULFILL YOUR BEING.")
  :config
  (dashboard-setup-startup-hook))

(provide 'user-dashboard)
;;; init-dashboard.el ends here.
