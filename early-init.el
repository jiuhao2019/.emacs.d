
(setq gc-cons-threshold most-positive-fixnum) ;; 只在空闲时进行 GC ，最大程度避免 GC 停顿导致的卡顿
(setq read-process-output-max (* 1024 1024)) ;; 1mb
;; 从子进程一次读取的最大字节数，默认是 4K ，对于使用 JSON 通信的 LSP 协议来说，太小了
;; 调大这个值可以减少系统调用次数
