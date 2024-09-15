(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.1)
                  (org-level-2 . 1.0)
                  (org-level-3 . 0.95)
                  (org-level-4 . 0.9)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
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
  (setq org-cycle-include-plain-lists 'integrate) ;;将列表视为heading,也可以折叠
  (setq org-image-actual-width nil)
  (setq org-export-preserve-breaks t);;导出时保留原样换行
  (setq org-ellipsis " ▼")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files (directory-files-recursively "/media/2T/file_on_home_archlinux/2024/" "\\.org$"));;递归搜寻
  (setq org-html-validation-link nil)

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit t)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
	'((sequence "BEGIN(t!)" "DOING(n!)" "HOLDING(h!)" "|" "DONE(d@/!)")
	  (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "|" "COMPLETED(c)" "CANC(k@)")))


  (setq org-tag-alist
	'((:startgroup)
					; Put mutually exclusive tags here
	  (:endgroup)
	  ("wk" . ?i)))

  (setq org-capture-templates nil)

  (add-to-list 'org-capture-templates '("t" "Tasks"))
  (add-to-list 'org-capture-templates
               '("tr" "Book Reading Task" entry
                 (file+olp "/media/2T/file_on_home_archlinux/2024/schedule.org" "Reading" "Book")
                 "* TODO %^{书名}\n%u\n%a\n" :clock-in t :clock-resume t))
  (add-to-list 'org-capture-templates
               '("tw" "Work Task" entry
                 (file+headline "/media/2T/file_on_home_archlinux/2024/schedule.org" "work")
                 "* TODO %^{任务名}\n%u\n%a\n" :clock-in t :clock-resume t))
  (add-to-list 'org-capture-templates
               '("j" "Journal" entry (file "/media/2T/file_on_home_archlinux/2024/journal.org")
		 "* %U - %^{heading}\n  %?"))
  (add-to-list 'org-capture-templates
               '("i" "Inbox" entry (file "/media/2T/file_on_home_archlinux/2024/inbox.org")
		 "* %U - %^{heading} %^g\n %?\n"))
  (add-to-list 'org-capture-templates
               '("n" "Notes" entry (file "/media/2T/file_on_home_archlinux/2024/inbox.org")
		 "* %^{heading} %t %^g\n  %?\n"))
  (add-to-list 'org-capture-templates
               '("b" "Billing" plain
		 (file+function "/media/2T/file_on_home_archlinux/2024/billing.org" find-month-tree)
		 " | %U | %^{类别} | %^{描述} | %^{金额} |" :kill-buffer t))
  (add-to-list 'org-capture-templates '("c" "contacts"))
  (add-to-list 'org-capture-templates
               '("c1" "Contacts1" table-line (file "/media/2T/file_on_home_archlinux/2024/contacts.org")
		 "| %U | %^{姓名} | %^{手机号}| %^{邮箱} |"))
  (add-to-list 'org-capture-templates
               '("c2" "Contacts2" entry (file "/media/2T/file_on_home_archlinux/2024/contacts.org")
		 "* %^{姓名} %^{手机号}p %^{邮箱}p %^{住址}p\n\n  %?" :empty-lines 1))
  (add-to-list 'org-capture-templates
               '("p" "Passwords" entry (file "/media/2T/file_on_home_archlinux/2024/passwords.org.cpt")
		 "* %U - %^{title} %^G\n\n  - 用户名: %^{用户名}\n  - 密码: %(get-or-create-password)"
		 :empty-lines 1 :kill-buffer t))
  (setq org-refile-targets
	'(("Archive.org" :maxlevel . 1)
	  ("Tasks.org" :maxlevel . 1)))
  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (efs/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  ;; (org-bullets-bullet-list '("◉" "○" "●" "⊙" "⊚" "◑" "◐" "◎" "○" "◊" "◇" "▶" "▷" "◆" "◇")))
  (org-bullets-bullet-list '("◉" "○" "●" "▶" "◆" "◑" "◐" "◎" "○" "◊" "◇" "▶" "▷" "◆" "◇")))

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

;;begin-> org-roam
(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "/media/2T/user-note"))
  (setq org-roam-db-location (concat "/media/2T/user-note/org-roam-db/org-roam-" system-name ".db"))
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
  :bind (("C-c n s" . mrds/roam-switch-directory))
  :config
  (or mrds--roam-root-directory (setq mrds--roam-root-directory (file-truename "/media/2T/user-note"))) ;;same as org-roam-directory
  (setq mrds--db-cache-path (file-truename "/media/2T/user-note/org-roam-db")) ;;all sub db here
  (org-roam-db-autosync-mode 1)) ;; need to sync org roam db first
;;end-> org-roam

(provide 'user-org)
