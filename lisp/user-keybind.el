(use-package hydra
  :config
  ;;window
  (defhydra hydra-window (:hint nil)
  "
  | Navigation^^      | Placement^^         | Create, Delete^^          | Adjustment^^         |
  |^^-----------------+^^-------------------+^^-------------------------+^^--------------------|
  | _h_: go left      | _H_: move to left   | _v_: split vertically     | _=_: balance windows |
  | _j_: go down      | _J_: move to bottom | _s_: split horizontally   | _+_: increase height |
  | _k_: go up        | _K_: move to top    | _q_: delete window        | _-_: decrease height |
  | _l_: go right     | _L_: move to right  | _Q_: delete other windows | _>_: increase width  |
  | ^^                | ^^                  | ^^                        | _<_: decrease width  |
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
    ("v"   evil-window-vsplit nil :color blue)))
;;
(use-package general
  :after evil
  :config
  (general-create-definer user/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")
  (user/leader-keys
    "w" '(hydra-window/body :which-key "+window")
    "t" '(neotree-toggle :which-key "neotree")
    "h" '(avy-goto-char-timer :which-key "hop")
    "u" '(undo-tree-visualize :which-key "undotree")
    "r" '(fzf-recentf :which-key "recentf")
    "k" '(highlight-symbol-at-point :which-key "highlight-toggle")
    "K" '(highlight-symbol-remove-all :which-key "clr-highlight")
    "f" '(fzf-find-file :which-key "find-file")
    "s" '(fzf-grep :which-key "rg")))

(provide 'user-keybind)
