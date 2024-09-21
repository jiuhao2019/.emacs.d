(use-package hydra)
;; 
(defhydra hydra-ztree (:hint nil)
  "
                                                                      ╭────────────┐
       Move      File                 Do                              │ Ztree diff │
    ╭─────────────────────────────────────────────────────────────────┴────────────╯
      _k_       [_C_] copy                  [_h_] toggle equal files
      ^ ^↑^ ^   [_D_] delete                [_x_] toggle subtree
      ^_TAB_^   [_v_] view                  [_r_] partial rescan
      ^ ^↓^ ^   [_d_] simple diff           [_R_] full rescan
      _j_       [_RET_] diff/expand         [_g_] refresh
      ^ ^       [_SPC_] simple diff/expand
    --------------------------------------------------------------------------------
          "
  ("<ESC>" nil "quit")
  ("k" previous-line)
  ("j" next-line)
  ("C" ztree-diff-copy)
  ("h" ztree-diff-toggle-show-equal-files)
  ("D" ztree-diff-delete-file)
  ("v" ztree-diff-view-file)
  ("d" ztree-diff-simple-diff-files)
  ("r" ztree-diff-partial-rescan)
  ("R" ztree-diff-full-rescan)
  ("RET" ztree-perform-action)
  ("SPC" ztree-perform-soft-action)
  ("TAB" ztree-jump-side)
  ("g" ztree-refresh-buffer)
  ("x" ztree-toggle-expand-subtree))
(defhydra hydra-bookmark (:hint nil)
  "
    ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
    [_t_] bookmark-set           [_r_] bookmark-rename
    [_j_] bookmark-jump          [_d_] bookmark-delete
    [_s_] bookmark-save          ^^
  "
  ("t"   bookmark-set nil :color blue)
  ("j"   bookmark-jump :color blue)
  ("s"   bookmark-save :color blue)
  ("r"   bookmark-rename :color blue)
  ("d"   bookmark-delete nil :color blue))
;;-------------------------------------------------------window
(defhydra hydra-window (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_h_] go left     [_H_] move to left      [_s_] fork horizontally         [_=_] balance windows       
   [_j_] go down     [_J_] move to bottom    [_v_] fork vertically           [_+_] increase height       
   [_l_] go up       [_L_] move to right     [_q_] delete window             [_-_] decrease height       
   [_k_] go right    [_K_] move to top       [_Q_] delete other windows      [_>_] increase width        
   ^^                ^^                      ^^                              [_<_] decrease width
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
  ("q"   evil-window-delete)
  ("Q"   delete-other-windows)
  ("+"   evil-window-increase-height)
  ("-"   evil-window-decrease-height)
  ("<"   evil-window-decrease-width)
  (">"   evil-window-increase-width)
  ("="   balance-windows))
;;-------------------------------------------------------end window
;;-------------------------------------------------------search
(defhydra hydra-search (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_m_] douban-movie      [_o_] google        [_g_] github       [_w_] wikipedia      
   [_b_] douban-book       [_d_] duckgo        [_y_] youtube      [_a_] annas-archive  
   [_z_] zhihu             [_s_] scholar       [_l_] bilibili     ^^ 
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
(defhydra hydra-org-roam (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_i_] org-id-get-create           
   [_n_] org-roam-node-find           
   [_s_] org-roam-db-sync                          
   [_u_] org-roam-ui-open                          
   [_d_] mrds/roam-switch-directory    
"
  ("i"   org-id-get-create nil :color blue)
  ("n"   org-roam-node-find nil :color blue)
  ("s"   org-roam-db-sync nil :color blue)
  ("u"   org-roam-ui-open nil :color blue)
  ("d"   mrds/roam-switch-directory nil :color blue))
;;  org-agenda
(defhydra hydra-org-agenda (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_a_] org-agenda           
  "
  ("a"   org-agenda nil :color blue))
;;  org-clock
(defhydra hydra-org-clock (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_i_] org-clock-in           
   [_o_] org-clock-out                          
   [_r_] org-clock-report                          
  "
  ("i"   org-clock-in nil :color blue)
  ("o"   org-clock-out nil :color blue)
  ("r"   org-clock-report nil :color blue))
;;  plain list
(defhydra hydra-org-plain-list (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_I_] org-insert-todo-heading                          
   [_u_] org-shiftmetaup                          
   [_d_] org-shiftmetadown                          
   [_-_] toggle-display-style                          
  "
  ("I"   org-insert-todo-heading nil :color blue)
  ("u"   org-shiftmetaup)
  ("-"   org-ctrl-c-minus)
  ("d"   org-shiftmetadown))
;;  table
(defhydra hydra-org-table (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_c_] org-table-create                          
  "
  ("c"   org-table-create nil :color blue))

(defhydra hydra-org (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_t_] org-toggle-inline-images       [_p_] org-capture           [_a_] +org-agenda           
   [_o_] org-html-export-to-html        [_i_] org-meta-return       [_l_] +plain-list    
   [_w_] org-refile                     ^^                          [_r_] +org-roam   
   [_g_] org-set-tags-command           ^^                          [_c_] +org-clock
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
  ("a"   hydra-org-agenda/body nil :color blue))
;;-------------------------------------------------------end org
(defhydra hydra-help (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_b_] counsel-descbinds          
   [_f_] counsel-describe-function  
   [_v_] counsel-describe-variable    
   [_m_] info-display-manual    
  "
  ("b"   counsel-descbinds nil :color blue)
  ("f"   counsel-describe-function nil :color blue)
  ("v"   counsel-describe-variable nil :color blue)
  ("m"   info-display-manual nil :color blue))
(defhydra hydra-buffer (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_a_] user-alternate-buffers          
   [_c_] user-diff-buffer-with-file  
  "
  ("a"   user-alternate-buffers nil :color blue)
  ("c"   user-diff-buffer-with-file nil :color blue))
(defhydra hydra-drag-stuff (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_h_] drag-stuff-left          
   [_j_] drag-stuff-down  
   [_k_] drag-stuff-up  
   [_l_] drag-stuff-right  
  "
  ("h"   drag-stuff-left )
  ("j"   drag-stuff-down )
  ("k"   drag-stuff-up )
  ("l"   drag-stuff-right ))
(defhydra hydra-misc (:hint nil)
  "
   ∈━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━∋
   [_n_] neotree-toggle                       [_s_] scratch-buffer  
   [_w_] toggle-show-trailing-whitespace          
   [_d_] define-word  
   [_t_] google-translate-at-point  
  "
  ("n"   neotree-toggle nil :color blue)
  ("w"   toggle-show-trailing-whitespace :color blue)
  ("d"   define-word :color blue)
  ("s"   scratch-buffer :color blue)
  ("t"   google-translate-at-point nil :color blue))
;;
(use-package general
  :after evil
  :config
  (general-create-definer user/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")
  (user/leader-keys
    "j" '(avy-goto-char-timer :which-key "jump")
    "U" '(undo-tree-visualize :which-key)
    "r" '(fzf-recentf :which-key)
    "k" '(highlight-symbol-at-point :which-key)
    "K" '(highlight-symbol-remove-all :which-key)
    "f" '(fzf-find-file :which-key)
    "c" '(comment-line :which-key )
    "i" '(lsp-ui-imenu :which-key )
    "I" '(ialign :which-key )
    "b" '(hydra-buffer/body :which-key "+buffer")
    "x" '(hydra-misc/body :which-key "+misc")
    "o" '(hydra-org/body :which-key "+org")
    "w" '(hydra-window/body :which-key "+window")
    "h" '(hydra-help/body :which-key "+help")
    "z" '(ztree-diff :which-key "ztree-diff")
    "m" '(hydra-bookmark/body :which-key "+bookmark")
    "d" '(hydra-drag-stuff/body :which-key "+drag-stuff")
    "s" '(hydra-search/body :which-key "+search")))

(provide 'user-keybind)
