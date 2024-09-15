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

(provide 'user-func)
