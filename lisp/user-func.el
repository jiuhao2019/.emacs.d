(defun user/counsel-rg-at-point (str &optional from to)
  "搜索text,先v选中,或者默认光标处单词"
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
      ( counsel-rg input-str ))))

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
;;导出excel或csv方式1
(defun org-table-export-to-spreadsheet (arg)
  "Export org table to spreadsheet formats, e.g. `ods', `xls', `xlsx'."
  (interactive "sFormat: ")
  (let* ((source-file  (file-name-sans-extension (buffer-file-name  (current-buffer))))
	 (csv-file (concat source-file ".csv")))
    (org-table-export csv-file "orgtbl-to-csv")
    (org-odt-convert csv-file arg)))
;;导出excel或csv方式2
(defun my/table-export ()
  (interactive)
  (org-table-export "/tmp/table.csv" "orgtbl-to-csv")
  (shell-command-to-string "localc --headless --infilter=\"CSV:44,34,76,,,,,,true,,,,false\" --convert-to \"xlsx:Calc MS Excel 2007 XML:UTF8\" /tmp/table.csv --outdir /tmp/"))

;;
(provide 'user-func)
