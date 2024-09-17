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

;;=======================================begin: 创建capture(消费记录类型)时统计表格数据
(defun get-year-and-month ()
  (list (format-time-string "%Y年") (format-time-string "%m月")))

(defun find-month-tree ()
  (let* ((path (get-year-and-month))
         (level 1)
         end)
    (unless (derived-mode-p 'org-mode)
      (error "Target buffer \"%s\" should be in Org mode" (current-buffer)))
    (goto-char (point-min))             ;移动到 buffer 的开始位置
    ;; 先定位表示年份的 headline，再定位表示月份的 headline
    (dolist (heading path)
      (let ((re (format org-complex-heading-regexp-format
                        (regexp-quote heading)))
            (cnt 0))
        (if (re-search-forward re end t)
            (goto-char (point-at-bol))  ;如果找到了 headline 就移动到对应的位置
          (progn                        ;否则就新建一个 headline
            (or (bolp) (insert "\n"))
            (if (/= (point) (point-min)) (org-end-of-subtree t t))
            (insert (make-string level ?*) " " heading "\n"))))
      (setq level (1+ level))
      (setq end (save-excursion (org-end-of-subtree t t))))
    (org-end-of-subtree)))
;;=======================================end
;;=======================================begin: 创建capture(密码类型)时输入密码为空时自动生成一个密码
(defun random-alphanum ()
  (let* ((charset "abcdefghijklmnopqrstuvwxyz0123456789")
         (x (random 36)))
    (char-to-string (elt charset x))))

(defun create-password ()
  (let ((value ""))
    (dotimes (number 16 value)
      (setq value (concat value (random-alphanum))))))

(defun get-or-create-password ()
  (setq password (read-string "Password: "))
  (if (string= password "")
      (create-password)
    password))
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

(provide 'user-func)
