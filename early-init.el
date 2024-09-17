
;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 1.0)

;; use package.el install packages
(setq package-enable-at-startup nil)


;;; early-init.el ends here
