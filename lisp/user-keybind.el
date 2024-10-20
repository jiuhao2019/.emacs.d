(use-package hydra )
;; 
(defhydra hydra-bookmark (:hint nil )
  "
[_s_] set    [_d_] delete
[_j_] jump   ^^
[_w_] save   ^^
[_r_] rename ^^
"
  ("s"   bookmark-set nil :color blue)
  ("j"   bookmark-jump nil :color blue)
  ("w"   bookmark-save nil :color blue)
  ("r"   bookmark-rename nil :color blue)
  ("d"   bookmark-delete nil :color blue))
;;-------------------------------------------------------window
(defhydra hydra-window (:hint nil )
  "
[_h_] go left  [_H_] move to left   [_s_] fork-to-right [_+_] inc height [_=_] balance-win
[_j_] go down  [_J_] move to bottom [_v_] fork-to-below [_-_] dec height ^^
[_l_] go up    [_L_] move to right  [_x_] del-win       [_>_] inc width  ^^
[_k_] go right [_K_] move to top    [_X_] del-other-win [_<_] dec width  ^^
"
  ("h"   evil-window-left)
  ("j"   evil-window-down)
  ("k"   evil-window-up)
  ("l"   evil-window-right)
  ("H"   evil-window-move-far-left)
  ("J"   evil-window-move-very-bottom)
  ("K"   evil-window-move-very-top)
  ("L"   evil-window-move-far-right)
  ("s"   evil-window-split nil :color blue)
  ("v"   evil-window-vsplit nil :color blue)
  ("x"   evil-window-delete)
  ("X"   delete-other-windows)
  ("+"   evil-window-increase-height)
  ("-"   evil-window-decrease-height)
  ("<"   evil-window-decrease-width)
  (">"   evil-window-increase-width)
  ("="   balance-windows))
;;-------------------------------------------------------end window
;;-------------------------------------------------------begin org
;;  org-roam
(defhydra hydra-org-roam (:hint nil )
  "
[_c_] org-id-get-create 
[_i_] node-insert
[_n_] node-find
[_s_] db-sync
"
  ("c"   org-id-get-create nil :color blue)
  ("i"   org-roam-node-insert nil :color blue)
  ("n"   org-roam-node-find nil :color blue)
  ("s"   org-roam-db-sync nil :color blue))
;;  org-agenda
(defhydra hydra-org-agenda (:hint nil )
  "
[_]_] remove-file [_s_] schedule-time
[_[_] add-file    [_d_] deadline-time
[_a_] agenda      ^^
[_t_] todo        ^^
"
  ("["   org-agenda-file-to-front nil :color blue)
  ("]"   org-remove-file nil :color blue)
  ("a"   org-agenda nil :color blue)
  ("s"   org-schedule nil :color blue)
  ("d"   org-deadline nil :color blue)
  ("t"   org-todo nil :color blue))
;;  org-clock
(defhydra hydra-org-clock (:hint nil )
  "
[_i_] clock-in
[_o_] clock-out
[_r_] clock-report
"
  ("i"   org-clock-in nil :color blue)
  ("o"   org-clock-out nil :color blue)
  ("r"   org-clock-report nil :color blue))
;;  plain list
(defhydra hydra-org-plain-list (:hint nil )
  "
[_i_] insert
[_u_] shift-up
[_d_] shift-down
[_-_] style
"
  ("i"   org-insert-todo-heading nil :color blue)
  ("u"   org-shiftmetaup)
  ("-"   org-ctrl-c-minus)
  ("d"   org-shiftmetadown))
;;  table
(defhydra hydra-org-table (:hint nil )
  "
[_c_] create
[_1_] export-spreadsheet
[_2_] export-spreadsheet_ng
"
  ("c"   org-table-create nil :color blue)
  ("1"   org-table-export-to-spreadsheet nil :color blue)
  ("2"   my/table-export nil :color blue))
;;  link
(defhydra hydra-org-link (:hint nil )
  "
[_o_] open
[_t_] display
[_i_] insert-or-edit
"
  ("o"   org-open-at-point nil :color blue)
  ("t"   org-toggle-link-display nil :color blue)
  ("i"   org-insert-link nil :color blue))
;;  block
(defhydra hydra-org-block (:hint nil )
  "
[_i_] insert-block
"
  ("i"   org-insert-structure-template nil :color blue))
(defhydra hydra-org (:hint nil )
  "
[_t_] inline-images [_a_] +agenda [_t_] +table
[_o_] export-html   [_l_] +list   [_L_] +link
[_i_] meta-return   [_r_] +roam   [_b_] +block
[_g_] tags          [_c_] +clock  ^^
"
  ("t"   org-toggle-inline-images nil :color blue)
  ("o"   org-html-export-to-html nil :color blue)
  ("i"   org-meta-return nil :color blue)
  ("g"   org-set-tags-command nil :color blue)
  ("t"   hydra-org-table/body nil :color blue)
  ("r"   hydra-org-roam/body nil :color blue)
  ("c"   hydra-org-clock/body nil :color blue)
  ("l"   hydra-org-plain-list/body nil :color blue)
  ("L"   hydra-org-link/body nil :color blue)
  ("b"   hydra-org-block/body nil :color blue)
  ("a"   hydra-org-agenda/body nil :color blue))
;;-------------------------------------------------------end org
(defhydra hydra-misc (:hint nil )
  "
 [_c_] comment    [_d_] dired     [_i_] indent-lisp-at-point           
 [_e_] theme      [_u_] undo-tree [_s_] rgrep
 [_j_] easymotion [_v_] valign     
 [_m_] imenu      [_r_] recentf              
 "
  ("d"   dired nil :color blue)
  ("s"   rgrep nil :color blue)
  ("e"   ap/switch-theme)
  ("v"   valign-mode nil :color blue);;表格里有中文也能对齐
  ("m"   counsel-imenu nil :color blue )
  ("c"   comment-line :color blue )
  ("j"   avy-goto-char-timer nil :color blue );;easymotion
  ("u"   undo-tree-visualize nil :color blue)
  ("r"   recentf nil :color blue)
  ("i"   aggressive-indent-indent-defun nil :color blue))
;;
(use-package general
  :after evil
  :config
  (general-create-definer user/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")
  (user/leader-keys
    "x" '(hydra-misc/body :which-key "+misc")
    "o" '(hydra-org/body :which-key "+org")
    "w" '(hydra-window/body :which-key "+window")
    "m" '(hydra-bookmark/body :which-key "+bookmark")))

(provide 'user-keybind)
