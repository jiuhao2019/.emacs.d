;;此包安装后，记得手动安装 M-x  all-the-icons-install-fonts
(use-package all-the-icons
  :if (display-graphic-p))

(use-package doom-modeline
  :init 
  (doom-modeline-mode 1)
  :custom 
  ((doom-modeline-height 15)))

;;doom themes
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
        doom-themes-enable-italic nil) ; if nil, italics is universally disabled
  (load-theme 'doom-moonlight t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;;gruvbox theme
;; (use-package gruvbox-theme
;;   :config
;;   (load-theme 'gruvbox-dark-hard t))

;;
(provide 'user-theme)
