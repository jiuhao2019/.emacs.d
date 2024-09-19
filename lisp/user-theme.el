(use-package doom-themes
  :init (load-theme 'doom-moonlight t))

(use-package all-the-icons
  :if (display-graphic-p))
(use-package all-the-icons-ivy-rich)

(use-package doom-modeline
  :init 
  (doom-modeline-mode 1)
  :custom 
  ((doom-modeline-height 15)))

(provide 'user-theme)
