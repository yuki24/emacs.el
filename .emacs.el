;; Interactively Do Things (highly recommended, but not strictly required)
 (require 'ido)
 (ido-mode t)
;; Rinari
 (add-to-list 'load-path "~/yuki/.emacs.d/rinari")
 (require 'rinari)
;; Rake files are ruby, too, as are gemspecs, rackup files, etc.
 (add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("\.gemspec$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("\.ru$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
 (add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;;日本語環境
(set-language-environment 'Japanese)

;; Carbon-font 設定
;;(if (eq window-system 'mac) (require 'carbon-font))
;;(fixed-width-set-fontset "hirakaku_w3" 10)

;; Mac固有設定
;; (when (eq system-type 'darwin)
;;   ;;Encoding
;;   (set-default-coding-systems 'utf-8-unix)
;;   (set-terminal-coding-system 'utf-8-unix)
;;   (set-keyboard-coding-system 'sjis-mac)
;;   (set-clipboard-coding-system 'sjis-mac)
;;   (setq-default buffer-file-coding-system 'utf-8)
;;   (prefer-coding-system 'utf-8)
;;   ;;diredで日本語の濁点・半濁点が化ける問題を解消
;;   (require 'utf-8m)
;;   (set-file-name-coding-system 'utf-8m)
;;   ;;Keybind
;;   (setq mac-command-key-is-meta nil)
;;  (setq mac-option-modifier 'meta)
;;   (setq mac-command-modifier 'alt)
;;   (setq mac-control-modifier 'control)
;;   ;;antialias
;;   (setq mac-allow-anti-aliasing t)
;;  
;;   ;;MacでCtrol-SpaceでMarkできない問題の解消
;;   (mac-add-ignore-shortcut '(? )) 
;;   (mac-add-ignore-shortcut '(control))
;;  
;;   ;;Quartz2Dのアンチエイリアスを利用
;;   (setq mac-allow-anti-aliasing t)
;; )

;; ステータスラインに時間を表示する
(if (equal (substring (concat 
			   (shell-command-to-string "defaults read -g AppleLocale") "__") 0 2) "ja")
	(progn
	  (setq dayname-j-alist
			'(("Sun" . "日") ("Mon" . "月") ("Tue" . "火") ("Wed" . "水")
		  ("Thu" . "木") ("Fri" . "金") ("Sat" . "土")))
	  (setq display-time-string-forms
		'((format "%s年%s月%s日(%s) %s:%s"
			  year month day
			  (cdr (assoc dayname dayname-j-alist))
			  24-hours minutes
			  load)))))
;;
;; 画面色設定
;;
(if (boundp 'window-system)
	(setq default-frame-alist
	  (append 
	   (list
		'(vertical-scroll-bars . nil) ;;スクロールバーはいらない
		'(width . 150)				  ;;ウィンドウ幅
		'(height . 85)				  ;;ウィンドウの高さ
		'(top .	   30)				  ;;表示位置
		'(left .   400)				  ;;表示位置
		'(alpha . (85 85))			  ;;透明度
		)
	   default-frame-alist)))

(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode)
(if window-system 
	(progn
	  ;; 文字の色を設定します。
	  (add-to-list 'default-frame-alist '(foreground-color . "grey60"))
	  ;; 背景色を設定します。
	  (add-to-list 'default-frame-alist '(background-color . "black"))
	  ;; カーソルの色を設定します。
	  (add-to-list 'default-frame-alist '(cursor-color . "gray70"))
	  ;; マウスポインタの色を設定します。
	  ;;(add-to-list 'default-frame-alist '(mouse-color . "SlateBlue2"))
	  ;; モードラインの文字の色を設定します。
	  (set-face-foreground 'modeline "grey70")
	  ;; モードラインの背景色を設定します。
	  (set-face-background 'modeline "MediumPurple4")
	  ;; 選択中のリージョンの色を設定します。
	  (set-face-background 'region "midnight blue")
	  ;; 色設定
	  (set-face-foreground 'font-lock-comment-face "DarkGreen")
	  (set-face-foreground 'font-lock-string-face "MediumPurple")
	  (set-face-foreground 'font-lock-keyword-face "LightSeaGreen")
	  (set-face-foreground 'font-lock-constant-face "LightGoldenRod")
	  (set-face-foreground 'font-lock-function-name-face "violet")
	  (set-face-foreground 'font-lock-variable-name-face "violet")
	  (set-face-foreground 'font-lock-type-face "LightSeaGreen")
	  (set-face-foreground 'font-lock-warning-face "violet")
	  (set-face-bold-p 'font-lock-function-name-face nil)
	  (set-face-bold-p 'font-lock-warning-face nil)
	  ))

;; シェルスクリプトを保存する際に自動的にchmod +xを行う
(add-hook 'after-save-hook
		  'executable-make-buffer-file-executable-if-script-p)
;; よそのウィンドウにはカーソルを表示しない
(setq cursor-in-non-selected-windows nil)
;; 画像ファイルを表示
(auto-image-file-mode)
;;ホイールマウス設定
(mouse-wheel-mode t)
(setq mouse-whieel-follow-mouse t)
;;yes or no を y or n に
(fset 'yes-or-no-p 'y-or-n-p)
;;対応する括弧を光らせる
(show-paren-mode t)
;;ツールバーを消す
;;(tool-bar-mode nil)
;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)
;;スクロールを１行ずつに
(setq comint-scroll-show-maximum-output t)
(setq scroll-conservatively 35
	  scroll-margin 0
	  scroll-step 1)
;;モードラインに時間を表示
(display-time)
;;リージョンに色を付ける
(setq transient-mark-mode t)
;;バッファを切り替えてもリージョンに色がついたままにする
(setq highlight-nonselected-windows t)
;;行数表示
(line-number-mode t)
(column-number-mode t)
;;マクロサーチパス設定
(setq load-path (append '("~/site-lisp") load-path))
(setq load-path (append '("~/site-lisp/w3m") load-path))
;;ビープ音を消す
(setq ring-bell-function (lambda ()))
;;バッテリー残量を表示する
;;(display-battery-mode t)
;;折り返さない
(setq truncate-lines t)
(setq truncate-partial-width-windows t)
;;Open Recentを追加(存在しないファイルもリストから削除しない)
(setq recentf-auto-cleanup 'never) 
(recentf-mode t)

;;GCの頻度を下げる
;;http://www.fan.gr.jp/~ring/Meadow/meadow.html
(setq gc-cons-threshold 5242880)(setq gc-cons-threshold 5242880)

;;elscreen
;;(setq elscreen-display-tab 15) ; タブの幅（６以上じゃないとダメ）
;;(setq elscreen-tab-display-kill-screen nil) ; タブの左端の×を非表示
;;(load "elscreen" "ElScreen" t)

;; linum
;;(require 'linum)
;;(global-linum-mode t)
;;(setq linum-format "%5d")

;; ;; C/Migemo設定
;; ;;
;; (setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "-e"))
;; ;; migemo-dict のパスを指定
;; (setq migemo-dictionary "/usr/local/share/migemo/euc-jp/migemo-dict")
;; (setq migemo-user-dictionary nil)
;; (setq migemo-regex-dictionary nil)
;; ;; キャッシュ機能を利用する
;; (setq migemo-use-pattern-alist t)
;; (setq migemo-use-frequent-pattern-alist t)
;; (setq migemo-pattern-alist-length 1024)
;; ;; 辞書の文字コードを指定．
;; (setq migemo-coding-system 'euc-jp-unix)

;; (load-library "migemo")
;; ;; 起動時に初期化も行う
;; (migemo-init)

;; dabbrev
;;(load "dabbrev-ja")
;;(require 'dabbrev-highlight)

;; dabbrev-expand-multiple
(require 'dabbrev-expand-multiple)
(global-set-key "\C-l" 'dabbrev-expand-multiple)		; dabbrev-expand

;; 補完候補を一度に5つにする
(setq dabbrev-expand-multiple-select-keys '("a" "s" "d" "f" "g"))
;; 複数候補表示に移るキーに / を足す
(add-to-list 'dabbrev-expand-multiple-multi-selection-keys "/")
;; 複数候補表示時に次の候補表示に使用するキーに n を足す
(add-to-list 'dabbrev-expand-multiple-next-keys "n")
;; 複数候補表示時に前の候補表示に使用するキーに p を足す
(add-to-list 'dabbrev-expand-multiple-previous-keys "p")
;; ツールチップを表示する秒数
(setq dabbrev-expand-multiple-tooltip-timeout 2000)
;; 10秒で消えるように設定する
(setq dabbrev-expand-multiple-tooltip-timeout 10)
;; 最初に展開した文字列に highlight をかける.
(setq dabbrev-expand-multiple-highlight-face 'highlight)
;; インライン表示のときに使用するフェイス.
(setq dabbrev-expand-multiple-inline-show-face 'underline)
;; インライン表示の見た目の変更 (アンダーラインをなしにする)
(setq dabbrev-expand-multiple-inline-show-face nil)
;; ツールチップの見た目の設定 M-x list-colors-display を参考に設定する.
(setq dabbrev-expand-multiple-tooltip-params
	  '((foreground-color . "grey60")
		(background-color . "navy blue")
		(border-color . "black")))

;;
;; Shell関連
;;
;; エスケープシーケンスを処理する
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; パスワードを隠す
(add-hook 'comint-output-filter-functions
		  'comint-watch-for-password-prompt)

;;
;; バッファ名を <2><3>...ではなく ディレクトリ名で表示
;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; バッファ名が変化するものの対応
(setq uniquify-ignore-buffers-re "*[^*]+*")

;;
;; Key setting
;;
(global-set-key "\M-?" 'help)							; M-?をHelp
(global-set-key "\C-h" 'delete-backward-char)			; C-hをBackSpace
(global-set-key "\C-\\" 'toggle-input-method)			; C-\で日本語入力
(global-set-key "\C-w" 'kill-region)					; Cut
(global-set-key "\M-w" 'copy-region-as-kill)			; Copy
(global-set-key "\C-y" 'yank)							; Paste
(global-set-key "\C-xj" 'goto-line)						; 指定行へジャンプ
;;(global-set-key "\C-xg" 'igrep-find)					; Grep-find
(global-set-key "\C-xg" 'grep-find)						; Grep-find
(global-set-key "\C-xp" 'previous-multiframe-window)	; 前のバッファへ移動
(global-set-key [S-right] 'enlarge-window-horizontally)	; バッファを水平方向に拡大
(global-set-key [S-left] 'shrink-window-horizontally)	; バッファを水平方向に縮小
(global-set-key [S-down] 'enlarge-window)				; バッファを垂直方向に拡大
(global-set-key [S-up] 'shrink-window)					; バッファを垂直方向に縮小
(global-set-key [M-kanji] 'ignore)						; Alt-Kanjiキーでベルがうっさいので無効化
(global-set-key "\C-j" 'ignore)							; For SKK

;;
;; リージョン内の文字をC-dで消す
;;
(defun delete-windows-like ()
  (interactive)
  (if mark-active
	  (progn
		(delete-region (point) (mark)))
	(progn
	  (delete-char 1)
	  )
	)
  )
(global-set-key "\C-d" 'delete-windows-like)
(delete-selection-mode 1)

;;
;; gtags
;;
;; (autoload 'gtags-mode "gtags" "" t)
;; (setq gtags-mode-hook
;; 	  '(lambda ()
;; 		 (local-set-key "\M-t" 'gtags-find-tag)
;; 		 (local-set-key "\M-r" 'gtags-find-rtag)
;; 		 (local-set-key "\M-s" 'gtags-find-symbol)
;; 		 (local-set-key "\C-t" 'gtags-pop-stack)
;;		 ))

;;タブ幅を 4 に設定
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;;タブ幅の倍数を設定
(setq tab-stop-list
	  '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
(add-hook 'c-mode-common-hook
		  '(lambda ()
			 (gtags-mode t)
			 (c-set-style "stroustrup")
			 (setq c-basic-offset 4)))

;;
;; lgrep(文字コード自動判別Grep)の設定
;;
;;(setq grep-command "lgrep -n -Ou8 ")
;;(setq grep-program "lgrep")

;;
;; igrep設定
;;
;; (autoload 'igrep "igrep"
;;   "*Run n`grep` PROGRAM to match EXPRESSION in FILES..." t)
;; (autoload 'igrep-find "igrep"
;;   "*Run `grep` via `find`..." t)
;; (autoload 'dired-do-igrep "igrep"
;;   "*Run `grep` on the marked (or next prefix ARG) files." t)
;; (autoload 'igrep-insinuate "igrep"
;;   "Define `grep' aliases for the corresponding `igrep' commands." t)
;; (autoload 'igrep-visited-files "igrep"
;;   "*Run `grep` ... on all visited files." t)
;; (autoload 'dired-do-igrep-find "igrep"
;;   "*Run `grep` via `find` on the marked (or next prefix ARG) directories." t)
;; (autoload 'Buffer-menu-igrep "igrep"
;;   "*Run `grep` on the files visited in buffers marked with '>'." t)
;; ;; 以下は lgrep を使うための設定
;; (setq igrep-program "lgrep")
;; (setq igrep-expression-option "-n -Oe ")

;;
;; ミニバッファで M-x 時のインクリメンタル補完
;;
;;(require 'mcomplete)
;さらによく使うヒストリを優先させる
;;(load "mcomplete-history")
;;(turn-on-mcomplete-mode)
;;ファイルを開く時に，カーソルキーだけで，ファイルを選択
;;カーソル上下で従来のヒストリ。ctrl+P,ctrl+nでファイル名補完
;;(require 'cycle-mini)
;;(define-key minibuffer-local-map [up] 'previous-history-element)
;;(define-key minibuffer-local-completion-map [up] 'previous-history-element)
;;(define-key minibuffer-local-must-match-map [up] 'previous-history-element)
;;(define-key minibuffer-local-ns-map [up] 'previous-history-element)
;;(define-key minibuffer-local-ns-map [down] 'next-history-element)
;;(define-key minibuffer-local-map [down] 'next-history-element)
;;(define-key minibuffer-local-completion-map [down] 'next-history-element)
;;(define-key minibuffer-local-must-match-map [down] 'next-history-element)

;;
;; jaspaceの設定
;; 
(setq buffer-display-table (make-display-table))
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□")
(if window-system
	(setq jaspace-alternate-eol-string "↓\n"))
(setq jaspace-highlight-tabs ?^)

;;
;; ファイルの末尾に[EOF]を表示
;;
(defun my-mark-eob ()
  (let ((existing-overlays (overlays-in (point-max) (point-max)))
		(eob-mark (make-overlay (point-max) (point-max) nil t t))
		(eob-text "[EOF]"))
	;; 急EOFマークを削除
	(dolist (next-overlay existing-overlays)
	  (if (overlay-get next-overlay 'eob-overlay)
		  (delete-overlay next-overlay)))
	;; 新規EOF マークの表示
	(put-text-property 0 (length eob-text)
					   'face '(foreground-color . "gray30") eob-text)
	(overlay-put eob-mark 'eob-overlay t)
	(overlay-put eob-mark 'after-string eob-text)))
(add-hook 'find-file-hooks 'my-mark-eob)

;;
;; iswitchb
;;
(require 'iswitchb)
(iswitchb-mode 1)
;; keybind
(add-hook 'iswitchb-define-mode-map-hook
		  'iswitchb-my-keys)
(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )

(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
		 (eq iswitchb-method iswitchb-default-method)
		 iswitchb-matches)
	(select-window
	 (get-buffer-window (cadr (buffer-list))))
	(let ((iswitchb-method 'samewindow))
	  (iswitchb-visit-buffer
	   (get-buffer (car iswitchb-matches))))
	(select-window (minibuffer-window))))

;; ;; iswitchbでMigemo
;; (setq iswitchb-regexp t)
;; (setq iswitchb-use-migemo-p t)
;; (defadvice iswitchb-get-matched-buffers
;;   (before iswitchb-use-migemo activate)
;; ;;	"iswitchb で migemo を使ってみる。"
;;   (when iswitchb-use-migemo-p
;; 	(ad-set-arg
;; 	 0 (migemo-get-pattern
;; 		(ad-get-arg 0)))))

;;
;; dired::バッファを新しく開かない
;;

(defun dired-find-alternate-file ()
  "In dired, visit this file or directory instead of the dired buffer."
  (interactive)
  (set-buffer-modified-p nil)
  (find-alternate-file (dired-get-filename)))

;; ;;
;; ;; w3m
;; ;;
;; (autoload 'w3m "w3m"
;;   "Interface for w3m on Emacs." t)
;; (autoload 'w3m-find-file "w3m"
;;   "Find a local file using emacs-w3m." t)
;; (autoload 'w3m-search "w3m-search"
;;   "Search words using emacs-w3m." t)
;; (autoload 'w3m-weather "w3m-weather"
;;   "Display a weather report." t)
;; (autoload 'w3m-antenna "w3m-antenna"
;;   "Report changes of web sites." t)
;; (autoload 'w3m-namazu "w3m-namazu"
;;   "Search files with Namazu." t)
;; ;; デフォルトで使う検索エンジン
;; (setq w3m-search-default-engine "google")
;; ;; 天気のデフォルト場所
;; (setq w3m-weather-default-area "東京都・東京")
;; ;; 画面右端3文字で折り返し
;; (setq w3m-fill-column -3)
;; ;; ホーム
;; (setq w3m-home-page "http://www.google.co.jp/")
;; ;; cookie
;; (setq w3m-use-cookies t)
;; ;; Inline画像表示
;; (setq w3m-display-inline-image t)
;; (put 'narrow-to-region 'disabled nil)

;; ;;
;; ;; Emacs.appからDictionary.appへ
;; ;;
;; (when (eq system-type 'darwin)
;;   (defun my-search-at-dictionary-app ()
;; 	""
;; 	(interactive)
;; 	(let* ((keyword (read-from-minibuffer
;; 					 " keyword: "
;; 					 (my-get-keyword)))
;; 		   (encoded-keyword (encode-coding-string keyword 'japanese-shift-jis)))
;; 	  (unless (string= encoded-keyword "")
;; 		(do-applescript (concat "
;; activate application \"Dictionary\"
;; tell application \"System Events\"
;; 	tell application process \"Dictionary\"
;; 		set value of text field 1 of group 1 of tool bar 1 of window 1 to \""
;; 								encoded-keyword "\"
;; 		click button 1 of text field 1 of group 1 of tool bar 1 of window 1
;; 	end tell
;; end tell
;; ")))))

;;   (defun my-get-keyword ()
;; 	""
;; 	(or (and
;; 		 transient-mark-mode
;; 		 mark-active
;; 		 (buffer-substring-no-properties
;; 		  (region-beginning) (region-end)))
;; 		(thing-at-point 'word)))

;;   (transient-mark-mode t)
;;   (global-set-key "\C-xw" 'my-search-at-dictionary-app)	; Dictionary.appで検索
;; )

;; フレームサイズ記憶
(defun my-window-size-save ()
  (let* ((rlist (frame-parameters (selected-frame)))
		 (ilist initial-frame-alist)
		 (nCHeight (frame-height))
		 (nCWidth (frame-width))
		 (tMargin (if (integerp (cdr (assoc 'top rlist)))
					  (cdr (assoc 'top rlist)) 0))
		 (lMargin (if (integerp (cdr (assoc 'left rlist)))
					  (cdr (assoc 'left rlist)) 0))
		 buf
		 (file "~/.framesize.el"))
	(if (get-file-buffer (expand-file-name file))
		(setq buf (get-file-buffer (expand-file-name file)))
	  (setq buf (find-file-noselect file)))
	(set-buffer buf)
	(erase-buffer)
	(insert (concat
			 ;; 初期値をいじるよりも modify-frame-parameters
			 ;; で変えるだけの方がいい?
			 "(delete 'width initial-frame-alist)\n"
			 "(delete 'height initial-frame-alist)\n"
			 "(delete 'top initial-frame-alist)\n"
			 "(delete 'left initial-frame-alist)\n"
			 "(setq initial-frame-alist (append (list\n"
			 "'(width . " (int-to-string nCWidth) ")\n"
			 "'(height . " (int-to-string nCHeight) ")\n"
			 "'(top . " (int-to-string tMargin) ")\n"
			 "'(left . " (int-to-string lMargin) "))\n"
			 "initial-frame-alist))\n"
			 ;;"(setq default-frame-alist initial-frame-alist)"
			 ))
	(save-buffer)
	))

(defun my-window-size-load ()
  (let* ((file "~/.framesize.el"))
	(if (file-exists-p file)
		(load file))))

(my-window-size-load)

;; Call the function above at C-x C-c.
(defadvice save-buffers-kill-emacs
  (before save-frame-size activate)
  (my-window-size-save))

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq-default ediff-auto-refine-limit 10000)

;; Wanderlust
;; (autoload 'wl "wl" "Wanderlust" t)
;; (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
;; (autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;;(defun copy-from-osx ()
;; (shell-command-to-string "pbpaste"))

;;(defun paste-to-osx (text &optional push)
;; (let ((process-connection-type nil))
;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;;(setq interprogram-cut-function 'paste-to-osx)
;;(setq interprogram-paste-function 'copy-from-osx)

