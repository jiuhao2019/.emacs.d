(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.21)
                  (org-level-2 . 1.15)
                  (org-level-3 . 1.15)
                  (org-level-4 . 1.15)
                  (org-level-5 . 1.15)
                  (org-level-6 . 1.15)
                  (org-level-7 . 1.15)
                  (org-level-8 . 1.15)))
    (set-face-attribute (car face) nil :font "Fira Code Nerd Font Mono" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :commands (org-capture org-agenda)
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-enforce-todo-dependencies t)
  (setq org-startup-folded 'content);;默认折叠所有标题
  ;; (setq org-startup-folded 'show2levels)
  (setq org-cycle-include-plain-lists 'integrate) ;;将列表视为heading,也可以折叠
  (setq org-image-actual-width nil)
  (setq org-export-preserve-breaks t);;导出时保留原样换行
  (setq org-ellipsis " ▼")
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-html-validation-link nil)
  ;;=========================================================org-agenda
  (setq org-agenda-start-with-log-mode t)
  ;; (setq org-agenda-files (directory-files-recursively "~/user-note" "\\.org.gpg$"));;递归搜寻
  (setq org-agenda-files nil);;打开emacs后清除用来agenda的文件,每次手动添加。
  (setq org-agenda-custom-commands
	'(("p" "office todo"
	   ((tags-todo "office"
		       ((org-agenda-overriding-header "[ office todo task ]")))))))
  (push '("r" "月度" ((agenda "" ((org-agenda-span 37)
                                  (org-agenda-start-day "-30d")))))
	org-agenda-custom-commands)

  (setq org-todo-keywords
	'((sequence "TODO(t)" "PROCESS(p)" "|" "FINISHED(f@/!)" "DONE(d@/!)")))
  (setq org-tag-alist
	'((:startgroup)
					; Put mutually exclusive tags here
	  (:endgroup)
	  ("office" . ?o)
	  ("week" . ?w)))

  (setq org-capture-templates nil)
  (add-to-list 'org-capture-templates
               '("t" "Task" entry (file "~/user-note/capture_task.org.gpg")
                 "* TODO %^{heading} %^g\n %?\n"))
  (add-to-list 'org-capture-templates
               '("n" "Note" entry (file "~/user-note/capture_note.org.gpg")
		 "* %^{heading} %^g\n %?\n"))

  (setq org-refile-targets
	'(("~/user-note/note.org.gpg" :maxlevel . 2)
	  ("~/user-note/schedule.org.gpg" :maxlevel . 2)))
  (advice-add 'org-refile :after 'org-save-all-org-buffers);; Save Org buffers after refiling!
  (efs/org-font-setup))
;;=========================================================end org-agenda
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●" "○" "●")))

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))
(add-hook 'org-mode-hook  (lambda ()
                            (setq prettify-symbols-alist
				              '(("lambda" . ?λ)
				                (":PROPERTIES:" . ?)
				                (":ID:" . ?)
				                (":END:" . ?)
				                ("#+TITLE:" . ?)
				                ("#+title:" . ?)
				                ("#+AUTHOR:" . ?)
				                ("#+BEGIN_QUOTE" . ?)
				                ("#+END_QUOTE" . ?)
				                ("#+RESULTS:" . ?)
				                ("[ ]" . ?)
				                ("[-]" . ?)
				                ("[X]" . ?)
				                ("[#A]" . ?🅐)
				                ("[#B]" . ?🅑)
				                ("[#C]" . ?🅒)))
                            (prettify-symbols-mode)))
(setq epa-file-cache-passphrase-for-symmetric-encryption t);;对称加密时缓存密码，不用每次打开和保存都输入
;;关闭emacs后关闭后台gpg-agent，清除缓存的密码
(add-hook 'kill-emacs-hook (defun personal--kill-gpg-agent ()
                             (shell-command "pkill gpg-agent")))
;;=============================begin-> org-roam
(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "~/user-note"))
  (setq org-roam-db-location (concat "~/user-note/org-roam-db/org-roam-" system-name ".db"))
  (setq find-file-visit-truename t)
  (org-roam-db-autosync-mode)
  (setq org-roam-node-display-template
	(concat "${title:*} "
		(propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-database-connector 'sqlite-builtin)
  (setq org-roam-v2-ack t)
  (require 'org-roam-protocol)
  (org-roam-setup))

(use-package org-roam-ui)
(use-package simple-httpd)
(use-package websocket)
(use-package magit)

(use-package mrds-mode;;switch org-roam-db folder 
  :straight (:host github :repo "Imymirror/mrds-mode")
  :config
  (or mrds--roam-root-directory (setq mrds--roam-root-directory (file-truename "~/user-note"))) ;;same as org-roam-directory
  (setq mrds--db-cache-path (file-truename "~/user-note/org-roam-db")) ;;all sub db here
  (org-roam-db-autosync-mode 1)) ;; need to sync org roam db first
;;===============================end-> org-roam
(provide 'user-org)
