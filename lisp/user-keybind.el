(use-package hydra
  :config
  ;;window
  (defhydra hydra-window (:hint nil)
    "
   [_h_] go left       [_H_] move to left    [_v_] split vertically      [_=_] balance windows 
   [_j_] go down       [_J_] move to bottom  [_s_] split horizontally    [_+_] increase height 
   [_k_] go up         [_K_] move to top     [_q_] delete window         [_-_] decrease height 
   [_l_] go right      [_L_] move to right   [_Q_] delete other windows  [_>_] increase width  
   ^^                  ^^                    ^^                          [_<_] decrease width  
  "
    ("+"   evil-window-increase-height)
    ("-"   evil-window-decrease-height)
    ("<"   evil-window-decrease-width)
    (">"   evil-window-increase-width)
    ("="   balance-windows)
    ("H"   evil-window-move-far-left)
    ("J"   evil-window-move-very-bottom)
    ("K"   evil-window-move-very-top)
    ("L"   evil-window-move-far-right)
    ("h"   evil-window-left)
    ("j"   evil-window-down)
    ("k"   evil-window-up)
    ("l"   evil-window-right)
    ("q"   evil-window-delete)
    ("Q"   delete-other-windows)
    ("s"   evil-window-split nil :color blue)
    ("v"   evil-window-vsplit nil :color blue))
  ;;  1,fzf-rg-in-dir 指定文件夹搜索
  ;;  2,指定搜索引擎打开网页浏览器搜索
  (defhydra hydra-search (:hint nil)
    "
   [_m_] DoubanMovie   [_d_] DuckDuckGo [_l_] Bilibili      
   [_b_] DoubanBook    [_s_] Scholar    [_w_] WikiPedia_en  
   [_z_] Zhihu         [_g_] Github     [_a_] Annas-Archvie 
   [_o_] Google        [_y_] Youtube    [_r_] fzf-rg        
  "
    ("m"   my/search-doubanmovie nil :color blue)
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
  ;;  org-mode相关
  (defhydra hydra-org (:hint nil)
    "
   [_a_] org-agenda          [_c_] org-capture               [_d_] mrds/roam-switch-directory 
   [_n_] org-roam-node-find  [_r_] org-refile                [_o_] org-html-export-to-html                           
   [_s_] org-roam-db-sync    [_i_] org-id-get-create         [_g_] org-set-tags-command                            
   [_u_] org-roam-ui-open    [_t_] org-toggle-inline-images  ^^                            
  "
    ("a"   org-agenda nil :color blue)
    ("n"   org-roam-node-find nil :color blue)
    ("s"   org-roam-db-sync nil :color blue)
    ("u"   org-roam-ui-open nil :color blue)
    ("c"   org-capture nil :color blue)
    ("r"   org-refile nil :color blue)
    ("i"   org-id-get-create nil :color blue)
    ("d"   mrds/roam-switch-directory nil :color blue)
    ("o"   org-html-export-to-html nil :color blue)
    ("g"   org-set-tags-command nil :color blue)
    ("t"   org-toggle-inline-images nil :color blue))
  ;;  org-mode相关
  (defhydra hydra-emacs (:hint nil)
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
  (defhydra hydra-buffer (:hint nil)
    "
   [_a_] user-alternate-buffers          
   [_c_] user-diff-buffer-with-file  
  "
    ("a"   user-alternate-buffers nil :color blue)
    ("c"   user-diff-buffer-with-file nil :color blue))
  (defhydra hydra-misc (:hint nil)
    "
   [_n_] neotree-toggle                     [_s_] scratch-buffer  
   [_w_] toggle-show-trailing-whitespace          
   [_d_] define-word  
   [_t_] google-translate-at-point  
  "
    ("n"   neotree-toggle nil :color blue)
    ("w"   toggle-show-trailing-whitespace :color blue)
    ("d"   define-word :color blue)
    ("s"   scratch-buffer :color blue)
    ("t"   google-translate-at-point nil :color blue))
  (defhydra hydra-bookmark (:hint nil)
    "
   [_t_] bookmark-set          
   [_j_] bookmark-jump          
   [_s_] bookmark-save  
   [_r_] bookmark-rename  
   [_d_] bookmark-delete  
  "
    ("t"   bookmark-set nil :color blue)
    ("j"   bookmark-jump :color blue)
    ("s"   bookmark-save :color blue)
    ("r"   bookmark-rename :color blue)
    ("d"   bookmark-delete nil :color blue))
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
    ("x" ztree-toggle-expand-subtree)))
;;
(use-package general
  :after evil
  :config
  (general-create-definer user/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")
  (user/leader-keys
    "h" '(avy-goto-char-timer :which-key "hop")
    "U" '(undo-tree-visualize :which-key)
    "r" '(fzf-recentf :which-key)
    "k" '(highlight-symbol-at-point :which-key)
    "K" '(highlight-symbol-remove-all :which-key)
    "f" '(fzf-find-file :which-key)
    "F" '(format-all-region-or-buffer :which-key)
    "c" '(comment-line :which-key )
    "i" '(lsp-ui-imenu :which-key )
    "I" '(ialign :which-key )
    "b" '(hydra-buffer/body :which-key "+buffer")
    "x" '(hydra-misc/body :which-key "+misc")
    "o" '(hydra-org/body :which-key "+org")
    "w" '(hydra-window/body :which-key "+window")
    "E" '(hydra-emacs/body :which-key "+Emacs")
    "z" '(ztree-diff :which-key "ztree-diff")
    "m" '(hydra-bookmark/body :which-key "+bookmark")
    "s" '(hydra-search/body :which-key "+search")))

(provide 'user-keybind)
