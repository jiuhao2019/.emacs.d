(use-package org
  :commands (org-capture org-agenda)
  :config
  (setq org-enforce-todo-dependencies t)
  (setq org-startup-folded 'content);;默认折叠所有标题
  (setq org-cycle-include-plain-lists 'integrate) ;;将列表视为heading,也可以折叠
  (setq org-image-actual-width nil)
  (setq org-export-preserve-breaks t);;导出时保留原样换行
  (setq org-ellipsis " ▼")
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-html-validation-link nil)
  (setq epa-file-cache-passphrase-for-symmetric-encryption t);;对称加密时缓存密码，不用每次打开和保存都输入

  ;;
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
  (setq org-capture-templates nil))

;;
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●" "○" "●")))

;;
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
  ;;设置默认新节点名称不含时间戳
  (setq org-roam-capture-templates
	'(("d" "default" plain "%?" :target
	   (file+head "${slug}.org" "#+title: ${title}\n")
           :unnarrowed  t)))
  (require 'org-roam-protocol))


;;关闭emacs后关闭后台gpg-agent，清除缓存的密码
(add-hook 'kill-emacs-hook (defun personal-kill-gpg-agent ()
                             (shell-command "pkill gpg-agent")))
(add-hook 'org-mode-hook (defun user/org-mode-setup() (org-indent-mode) (variable-pitch-mode 1)))
(add-hook 'org-mode-hook (defun user/truncate-line() (setq truncate-lines t)))

;;
(provide 'user-org)
