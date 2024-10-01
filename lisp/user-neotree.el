(use-package neotree)
(setq neo-theme (if (display-graphic-p) 'icons))
(setq neo-window-fixed-size nil)

(provide 'user-neotree)

;; Keybindings
;;
;; Only in Neotree Buffer:
;;
;; U                     Go up a directory
;; H                     Toggle display hidden files
