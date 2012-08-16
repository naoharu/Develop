;; -*- mode: emacs-lisp -*-
 
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(column-number-mode t)
'(show-paren-mode t))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(default ((t (:background "gray93" :foreground "navy"))))
'(cperl-array-face ((t (:foreground "darkslateblue"))))
'(cperl-hash-face ((t (:background "lightyellow2" :foreground "firebrick" :slant normal :weight bold))))
'(cperl-nonoverridable-face ((t (:foreground "royalblue"))))
'(cursor ((t (:background "navy"))))
'(font-lock-builtin-face ((t (:foreground "palevioletred"))))
'(font-lock-comment-face ((t (:foreground "dimgray"))))
'(font-lock-constant-face ((t (:foreground "seagreen"))))
'(font-lock-function-name-face ((t (:foreground "mediumblue" :weight bold))))
'(font-lock-keyword-face ((t (:foreground "slateblue"))))
'(font-lock-string-face ((t (:foreground "mediumvioletred"))))
'(font-lock-type-face ((t (:foreground "royalblue"))))
'(font-lock-variable-name-face ((t (:foreground "chocolate"))))
'(font-lock-warning-face ((t (:foreground "firebrick"))))
'(region ((((class color) (min-colors 88) (background light)) (:background "LightSteelBlue1")))))
 
(set-language-environment "Japanese")
 
(setq make-backup-files nil)
(setq completion-ignore-case t)
(setq default-indicate-empty-lines t)
(setq mode-require-final-newline nil)
(setq sentence-end-double-space nil)
(setq-default indent-tabs-mode nil)
(setenv "TZ" "JST-9")
(global-auto-revert-mode t)
(blink-cursor-mode nil)
(show-paren-mode t)
(tooltip-mode nil)
 
(setq ring-bell-function 'ignore)
(global-set-key [kanji] 'ignore)
 
(prefer-coding-system 'utf-8-dos)
(set-charset-priority 'ascii 'japanese-jisx0213.2004-1 'japanese-jisx0213-2
'katakana-jisx0201 'cp932)
(set-coding-system-priority 'utf-8 'shift_jis-2004 'iso-2022-jp-2004
'euc-jis-2004)
(set-file-name-coding-system 'cp932)
(setq quail-keyboard-layout-type "jp106")
 
(dolist (coding-system '(sjis euc-jp iso-2022-jp iso-2022-7bit shift_jis-2004
euc-jis-2004 iso-2022-jp-2004))
(coding-system-put coding-system :decode-translation-table
(get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put coding-system :encode-translation-table
(get 'japanese-ucs-cp932-to-jis-map 'translation-table)))
(defun jisx0213-post-read-conv (len)
(translate-region (point-min) (point-max)
(get 'jisx0213-to-unicode 'translation-table)))
(defun jisx0213-pre-write-conv (from to)
(translate-region (point-min) (point-max)
(get 'unicode-to-jisx0213 'translation-table)))
(dolist (coding-system '(shift_jis-2004 iso-2022-jp-2004 euc-jis-2004))
(coding-system-put coding-system :post-read-conversion
'jisx0213-post-read-conv)
(coding-system-put coding-system :pre-write-conversion
'jisx0213-pre-write-conv))
 
(setq-default w32-ime-mode-line-state-indicator "-")
(setq w32-ime-show-mode-line nil)
(w32-ime-initialize)
(setq default-input-method "W32-IME")
 
(setq default-frame-alist
(append '((top . 20)
(left . 20)
(height . 47))
default-frame-alist))
 
(setq scalable-fonts-allowed t)
(setq w32-enable-synthesized-fonts t)
 
(set-face-attribute 'default nil
:family "Consolas"
:height 100)
 
(setq ttf-japanese "メイリオ")
 
(set-fontset-font "fontset-default"
'japanese-jisx0212
'("ＭＳ ゴシック" . "iso10646-1"))
(set-fontset-font "fontset-default"
'japanese-jisx0213.2004-1
`(,ttf-japanese . "iso10646-1"))
(set-fontset-font "fontset-default"
'japanese-jisx0213-2
`(,ttf-japanese . "iso10646-1"))
(set-fontset-font "fontset-default"
'katakana-jisx0201
`(,ttf-japanese . "iso10646-1"))
(set-fontset-font "fontset-default"
'cp932
`(,ttf-japanese . "iso10646-1"))
(set-fontset-font "fontset-default"
'(#x3099 . #x309A)
`(,ttf-japanese . "iso10646-1"))
 
(add-to-list 'face-font-rescale-alist
'(".*メイリオ.*" . 1.1))
 
(defun char-after-nozero ()
(let ((c (char-after)))
(if (numberp c) c 0)))
 
(defun ucs-after ()
(let ((c (char-after-nozero)))
(encode-char c 'ucs)))
 
(defvar utf-sig-nosig-alist
'((utf-16le-with-signature . utf-16le)
(utf-16be-with-signature . utf-16be)
(utf-8-with-signature . utf-8)
 
(utf-32-be-unix . utf-32be-unix)
(utf-32-be-dos . utf-32be-dos)
(utf-32-be-mac . utf-32be-mac)
(utf-32-le-unix . utf-32le-unix)
(utf-32-le-dos . utf-32le-dos)
(utf-32-le-mac . utf-32le-mac)))
 
(defun char-to-hex-coding-patch (coding)
(if (assq (coding-system-base coding) utf-sig-nosig-alist)
(coding-system-change-eol-conversion
(cdr (assq (coding-system-base coding) utf-sig-nosig-alist))
(coding-system-eol-type coding))
coding))
 
(defun char-to-hex-coding (c coding)
(let ((i 0)
(estr (encode-coding-string
(string c)
(char-to-hex-coding-patch coding)))
(used-c (char-to-hex-coding-patch coding))
(res ""))
(if (string-match "iso-2022" (symbol-name coding))
(setq estr (replace-regexp-in-string "\x1b\\$?(?." "" estr)))
(while (&lt; i (length estr))
(setq res (concat res (format "%02X" (elt estr i))))
(setq i (1+ i)))
;;    (setq res (concat res "-" (symbol-name used-c)))
res))
 
(defvar mode-line-show-buffer-code t
"*非nilならUnicodeのほかにバッファコードをモード行に表示する。")
 
(defvar mode-line-char-code-added nil)
 
(defun mode-line-show-char-code ()
(let ((c (char-after-nozero)))
(concat
(format "--%04X" (ucs-after))
(if mode-line-show-buffer-code
(format "--%c:%s"
(coding-system-mnemonic buffer-file-coding-system)
(char-to-hex-coding (char-after-nozero)
buffer-file-coding-system)))
)))
 
(defun mode-line-add-char-code ()
(let ((len (length default-mode-line-format))
(term (elt default-mode-line-format
(1- (length default-mode-line-format)))))
(delq term default-mode-line-format)
(setq default-mode-line-format
(append default-mode-line-format
`((char-code-mode (:eval (mode-line-show-char-code)))
,term)
))
(setq mode-line-char-code-added t)))
 
(define-minor-mode char-code-mode
nil
nil nil nil
:global t
(if (and char-code-mode (not column-number-mode))
(column-number-mode t))
(unless mode-line-char-code-added
(mode-line-add-char-code)))
 
(char-code-mode t)
 
(defun japan-composition-function (gstring)
(if (= (lgstring-char-len gstring) 1)
(compose-gstring-for-graphic gstring)
(or (font-shape-gstring gstring)
(let ((glyph-len (lgstring-glyph-len gstring))
(last-char (lgstring-char gstring
(1- (lgstring-char-len gstring))))
(i 0)
glyph)
(while (and (&lt; i glyph-len)
(setq glyph (lgstring-glyph gstring i)))
(setq i (1+ i)))
(compose-glyph-string-relative gstring 0 i 0.1)))))
 
(aset composition-function-table ?゙
'(["[うかきくけこさしすせそたちつてとはひふへほゝウカキクケコサシスセソタチツテトハヒフヘホワヰヱヲヽ].[゙]?"
1 japan-composition-function]
[nil 0 japan-composition-function]))
(aset composition-function-table ?゚
'(["[かきくけこはひふへほカキクケコセツトハヒフヘホㇷ].[゚]?"
1 japan-composition-function]
[nil 0 japan-composition-function]))
(aset composition-function-table ?˩
'(["[˥].[˩]?" 1 japan-composition-function]
[nil 0 japan-composition-function]))
(aset composition-function-table ?˥
'(["[˩].[˥]?" 1 japan-composition-function]
[nil 0 japan-composition-function]))
 
;; 透過
(set-frame-parameter nil 'alpha 90)
(add-to-list 'default-frame-alist '(alpha . (0.85 0.75)))
 
;; No toolbar
(tool-bar-mode nil)
 
;; No splash
(setq inhibit-startup-message t)
