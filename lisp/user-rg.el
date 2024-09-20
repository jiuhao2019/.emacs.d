(use-package rg
  :custom
  (rg-group-result t)
  (rg-show-columns t)
  :config
  (add-to-list 'display-buffer-alist '("^\\*rg\\*"
                                       (display-buffer-in-side-window)
                                       (side . right)
                                       (window-width . 0.5)))
  (add-to-list 'rg-finish-functions (lambda (buffer _) (pop-to-buffer buffer))))

(setopt my/browser-engines
        '((DoubanMovie . "https://search.douban.com/movie/subject_search?search_text=")
          (DoubanBook . "https://search.douban.com/book/subject_search?search_text=")
          (Zhihu . "https://www.zhihu.com/search?type=content&q=")
          (Google . "https://www.google.com/search?q=")
          (DuckDuckGo . "https://duckduckgo.com/?t=h_&q=")
          (Scholar . "https://scholar.google.com/scholar?q=")
          (Github . "https://github.com/search?q=")
          (Youtube . "http://www.youtube.com/results?aq=f&oq=&search_query=")
          (Bilibili . "https://search.bilibili.com/all?keyword=")
          (WikiPedia_en . "https://en.wikipedia.org/w/index.php?search=")
          (Annas-Archvie . "https://annas-archive.org/search?q=")))

(defmacro my/define-search-functions ()
  "Dynamically define search functions for each search engine in `my/browser-engines`."
  `(progn
     ,@(mapcar (lambda (engine)
                 (let* ((engine-name (car engine))
                        (function-name (intern (format "my/search-%s" (downcase (symbol-name engine-name))))))
                   `(defun ,function-name (query)
                      ,(format "Search for QUERY using the %s engine." engine-name)
                      (interactive
                       (list (let ((default-query
                                    (if (and (eq system-type 'darwin)
                                             (featurep 'emt))
                                        (emt-word-at-point-or-forward)
                                      (thing-at-point 'word t))))
                               (if (region-active-p)
                                   (buffer-substring-no-properties (region-beginning) (region-end))
                                 (read-string (format "[%s] Enter search terms (default: %s): " ,(symbol-name engine-name) default-query))))))
                      (let ((search-url (concat ,(cdr engine) (url-encode-url query))))
                        (browse-url search-url))
                      (when (region-active-p)
                        (deactivate-mark)))))
               my/browser-engines)))

(add-hook 'on-first-input-hook (lambda ()
				 (my/define-search-functions)))

(provide 'user-rg)
