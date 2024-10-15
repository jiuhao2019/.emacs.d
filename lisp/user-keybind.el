(use-package hydra )
;; 
(defhydra hydra-bookmark (:hint nil )
  "
  [_s_] bookmark-set    [_d_] bookmark-delete
  [_j_] bookmark-jump   ^^
  [_w_] bookmark-save   ^^
  [_r_] bookmark-rename ^^
  "
  ("s"   bookmark-set nil :color blue)
  ("j"   bookmark-jump nil :color blue)
  ("w"   bookmark-save nil :color blue)
  ("r"   bookmark-rename nil :color blue)
  ("d"   bookmark-delete nil :color blue))
;;-------------------------------------------------------window
(defhydra hydra-window (:hint nil )
  "
  [_h_] go left  [_H_] move to left   [_s_] fork horizontally     [_+_] increase height [_=_] balance windows
  [_j_] go down  [_J_] move to bottom [_v_] fork vertically       [_-_] decrease height ^^
  [_l_] go up    [_L_] move to right  [_x_] delete window         [_>_] increase width  ^^
  [_k_] go right [_K_] move to top    [_X_] delete other windows  [_<_] decrease width  ^^
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
;;-------------------------------------------------------search
(defhydra hydra-search (:hint nil )
  "
  [_m_] douban-movie [_o_] google        [_g_] github
  [_b_] douban-book  [_d_] duckgo        [_y_] youtube
  [_z_] zhihu        [_s_] scholar       [_l_] bilibili
  [_w_] wikipedia    [_a_] annas-archive [_r_] fzf-grep-in-dir
  "
  ("m"   my/search-DoubanMovie nil :color blue)
  ("b"   my/search-doubanbook nil :color blue)
  ("z"   my/search-zhihu nil :color blue)
  ("o"   my/search-google nil :color blue)
  ("d"   my/search-duckduckgo nil :color blue)
  ("s"   my/search-scholar nil :color blue)
  ("g"   my/search-github nil :color blue)
  ("y"   my/search-youtube nil :color blue)
  ("l"   my/search-bilibili nil :color blue)
  ("w"   my/search-wikipedia_en nil :color blue)
  ("a"   my/search-annas-archvie nil :color blue)
  ("r"   fzf-grep-in-dir nil :color blue))
;;-------------------------------------------------------end search
;;-------------------------------------------------------begin org
;;  org-roam
(defhydra hydra-org-roam (:hint nil )
  "
  [_c_] org-id-get-create    [_u_] org-roam-ui-open
  [_i_] org-roam-node-insert [_d_] mrds/roam-switch-directory
  [_n_] org-roam-node-find
  [_s_] org-roam-db-sync
  "
  ("c"   org-id-get-create nil :color blue)
  ("i"   org-roam-node-insert nil :color blue)
  ("n"   org-roam-node-find nil :color blue)
  ("s"   org-roam-db-sync nil :color blue)
  ("u"   org-roam-ui-open nil :color blue)
  ("d"   mrds/roam-switch-directory nil :color blue))
;;  org-agenda
(defhydra hydra-org-agenda (:hint nil )
  "
  [_]_] org-remove-file          [_s_] org-schedule
  [_[_] org-agenda-file-to-front [_d_] org-deadline
  [_a_] org-agenda               ^^
  [_t_] org-todo                 ^^
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
  [_i_] org-clock-in
  [_o_] org-clock-out
  [_r_] org-clock-report
  "
  ("i"   org-clock-in nil :color blue)
  ("o"   org-clock-out nil :color blue)
  ("r"   org-clock-report nil :color blue))
;;  plain list
(defhydra hydra-org-plain-list (:hint nil )
  "
  [_i_] org-insert-todo-heading
  [_u_] org-shiftmetaup
  [_d_] org-shiftmetadown
  [_-_] toggle-display-style
  "
  ("i"   org-insert-todo-heading nil :color blue)
  ("u"   org-shiftmetaup)
  ("-"   org-ctrl-c-minus)
  ("d"   org-shiftmetadown))
;;  table
(defhydra hydra-org-table (:hint nil )
  "
  [_c_] org-table-create
  [_1_] export-to-spreadsheet
  [_2_] export-to-spreadsheet_ng
  "
  ("c"   org-table-create nil :color blue)
  ("1"   org-table-export-to-spreadsheet nil :color blue)
  ("2"   my/table-export nil :color blue))
;;  link
(defhydra hydra-org-link (:hint nil )
  "
  [_o_] org-open-at-point
  [_t_] org-toggle-link-display
  [_i_] org-insert-or-edit-link
  "
  ("o"   org-open-at-point nil :color blue)
  ("t"   org-toggle-link-display nil :color blue)
  ("i"   org-insert-link nil :color blue))
;;  block
(defhydra hydra-org-block (:hint nil )
  "
  [_i_] org-insert-structure-template
  "
  ("i"   org-insert-structure-template nil :color blue))
(defhydra hydra-org (:hint nil )
  "
  [_T_] org-toggle-inline-images [_p_] org-capture     [_a_] +org-agenda [_t_] +org-table
  [_o_] org-html-export-to-html  [_i_] org-meta-return [_l_] +plain-list [_L_] +org-link
  [_w_] org-refile               ^^                    [_r_] +org-roam   [_b_] +org-block
  [_g_] org-set-tags-command     ^^                    [_c_] +org-clock  ^^
  "
  ("T"   org-toggle-inline-images nil :color blue)
  ("o"   org-html-export-to-html nil :color blue)
  ("w"   org-refile nil :color blue)
  ("p"   org-capture nil :color blue)
  ("g"   org-set-tags-command nil :color blue)
  ("i"   org-meta-return nil :color blue)
  ("t"   hydra-org-table/body nil :color blue)
  ("r"   hydra-org-roam/body nil :color blue)
  ("c"   hydra-org-clock/body nil :color blue)
  ("l"   hydra-org-plain-list/body nil :color blue)
  ("L"   hydra-org-link/body nil :color blue)
  ("b"   hydra-org-block/body nil :color blue)
  ("a"   hydra-org-agenda/body nil :color blue))
;;-------------------------------------------------------end org
(defhydra hydra-help (:hint nil )
  "
  [_b_] counsel-descbinds
  [_f_] counsel-describe-function
  [_v_] counsel-describe-variable
  [_m_] info-display-manual
  "
  ("b"   counsel-descbinds nil :color blue)
  ("f"   counsel-describe-function nil :color blue)
  ("v"   counsel-describe-variable nil :color blue)
  ("m"   info-display-manual nil :color blue))
(defhydra hydra-buffer (:hint nil )
  "
  [_a_] user-alternate-buffers
  [_c_] user-diff-buffer-with-file
  "
  ("a"   user-alternate-buffers nil :color blue)
  ("c"   user-diff-buffer-with-file nil :color blue))
(defhydra hydra-drag-stuff (:hint nil )
  "
  [_h_] drag-stuff-left
  [_j_] drag-stuff-down
  [_k_] drag-stuff-up
  [_l_] drag-stuff-right
  "
  ("h"   drag-stuff-left )
  ("j"   drag-stuff-down )
  ("k"   drag-stuff-up )
  ("l"   drag-stuff-right ))
(defhydra hydra-misc (:hint nil )
  "
  [_n_] neotree-toggle                  [_s_] scratch-buffer       [_h_] hs-show-all   [_c_] comment-line                [_f_] fzf-find-file
  [_w_] toggle-show-trailing-whitespace [_e_] switch-theme         [_H_] hs-hide-all   [_u_] undo-tree-visualize         [_r_] fzf-recentf
  [_j_] avy-goto-char-timer             [_v_] valign-mode          [_M_] lsp-ui-imenu  [_K_] highlight-symbol-remove-all [_i_] ialign
  [_t_] google-translate-at-point       [_<TAB>_] hs-toggle-hiding [_m_] counsel-imenu [_k_] highlight-symbol-at-point   [_a_] toggle-truncate-lines
  "
  ("n"   neotree-toggle nil :color blue)
  ("w"   toggle-show-trailing-whitespace nil :color blue)
  ("s"   scratch-buffer nil :color blue)
  ("e"   ap/switch-theme)
  ("v"   valign-mode nil :color blue);;表格里有中文也能对齐
  ("M"   lsp-ui-imenu nil :color blue )
  ("m"   counsel-imenu nil :color blue )
  ("i"   ialign nil :color blue )
  ("c"   comment-line :color blue )
  ("<TAB>" hs-toggle-hiding nil :color blue ) ;;折叠光标处所在的大括号
  ("h"   hs-show-all nil :color blue ) ;;展开所有大括号
  ("H"   hs-hide-all nil :color blue ) ;;折叠所有大括号
  ("j"   avy-goto-char-timer nil :color blue );;easymotion
  ("u"   undo-tree-visualize nil :color blue)
  ("k"   highlight-symbol-at-point nil :color blue)
  ("K"   highlight-symbol-remove-all nil :color blue)
  ("f"   fzf-find-file nil :color blue)
  ("r"   fzf-recentf nil :color blue)
  ("a"   toggle-truncate-lines nil :color blue)
  ("t"   google-translate-at-point nil :color blue))
;;
(use-package general
  :after evil
  :config
  (general-create-definer user/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")
  (user/leader-keys
    "b" '(hydra-buffer/body :which-key "+buffer")
    "x" '(hydra-misc/body :which-key "+misc")
    "o" '(hydra-org/body :which-key "+org")
    "w" '(hydra-window/body :which-key "+window")
    "h" '(hydra-help/body :which-key "+help")
    "m" '(hydra-bookmark/body :which-key "+bookmark")
    "d" '(hydra-drag-stuff/body :which-key "+drag-stuff")
    "s" '(hydra-search/body :which-key "+search")))

(provide 'user-keybind)
