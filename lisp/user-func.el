(defun user-search-text-at-point (str &optional from to)
  "搜索当前文件里text,可以先v选中,或者默认光标处单词"
  (interactive
   ;; 判断当前是否选中了一个region，如果选中则获取region的起、始位置，并赋值给from、to；如果没有选中region则获取当前单词的起、始位置并赋值给from、to
   (if (use-region-p)
       (list nil (region-beginning) (region-end))
     (let ((bounds (bounds-of-thing-at-point 'word)))
       (list nil (car bounds) (cdr bounds)))))
  ;; 设置一个标志变量use-str-p，用于后续判断是否要操作region
  (let (use-str-p input-str output-str)
    (setq use-str-p (if str t nil))
    ;; 设置输入字符串的值，如果输入的字符串不为空，则设置为开始位置为from、结束位置为to的region的值
    (if use-str-p
	(setq input-str str)
      (setq input-str (buffer-substring-no-properties from to))
      ;;调用swiper搜索该字符串
      ( swiper input-str ))))

;;=======================================begin
;;Show/hide the trailing white-spaces in the buffer.
;; from http://stackoverflow.com/a/11701899/634816
(defun toggle-show-trailing-whitespace ()
  "Toggle show-trailing-whitespace between t and nil"
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace)))
;;=======================================end
;;=======================================begin
(defun user-alternate-buffers ()
  "Toggle between the last two buffers"
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) t)))

(defun user-revert-buffer ()
  "Revert the buffer to the save disk file state"
  (interactive)
  (revert-buffer nil t))

(defun user-diff-buffer-with-file ()
  "Compare the current modified buffer with the saved version."
  (interactive)
  (let ((diff-switches "-u"))
    (diff-buffer-with-file (current-buffer))))
;;=======================================end
;;--------------------------------------------------------switch themes
(defun ap/load-doom-theme (theme)
  "Disable active themes and load a Doom theme."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name)
                                                   (--select (string-prefix-p "doom-" it)))))))
  (ap/switch-theme theme)

  (set-face-foreground 'org-indent (face-background 'default)))

(defun ap/switch-theme (theme)
  "Disable active themes and load THEME."
  (interactive (list (intern (completing-read "Theme: "
                                              (->> (custom-available-themes)
                                                   (-map #'symbol-name))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme 'no-confirm))
;;--------------------------------------------------------end switch themes
(provide 'user-func)
