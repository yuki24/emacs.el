;;; -*- syntax: elisp -*-

;; Copyright (C) 2002-2003 Yasutaka SHINDOH <ring-pub@fan.gr.jp>

;; Author: Yasutaka SHINDOH <ring-pub@fan.gr.jp>
;; Keywords: convenience

;;; Commentary:

;; Sorry, not ready.

;;; Code:

(require 'elscreen)

(define-key global-map elscreen-prefix-key 'elscreen-plus)

(defvar elscreen-plus-map-alist
  '((?\C-c . elscreen-create)
    (?c    . elscreen-create)
    (?\C-k . elscreen-kill)
    (?k    . elscreen-kill)
    (?\C-p . elscreen-previous)
    (?p    . elscreen-previous)
    (?\C-n . elscreen-next)
    (?n    . elscreen-next)
    (?\C-a . elscreen-toggle)
    (?a    . elscreen-toggle)
    (?g    . elscreen-goto)
    (?0    . elscreen-jump)
    (?1    . elscreen-jump)
    (?2    . elscreen-jump)
    (?3    . elscreen-jump)
    (?4    . elscreen-jump)
    (?5    . elscreen-jump)
    (?6    . elscreen-jump)
    (?7    . elscreen-jump)
    (?8    . elscreen-jump)
    (?9    . elscreen-jump)
    (??    . elscreen-help)
    (?h    . elscreen-help)
    (?\C-f . elscreen-find-file)
    (?\C-r . elscreen-find-file-read-only)
    (?f    . elscreen-execute-extended-command)
    (?b    . elscreen-switch-to-buffer)
    (?\C-m . elscreen-show-last-message)
    (?m    . elscreen-show-last-message)
    (?t    . elscreen-show-time)
    (?A    . elscreen-name)
    (?v    . elscreen-show-version)
    (?i    . elscreen-number-mode-line)
    (?l    . elscreen-link)
    (?s    . elscreen-split)
    (?     . elscreen-plus)))

(defvar elscreen-plus-last-message nil)
(defvar elscreen-plus-wait-second nil)

(defadvice elscreen-message (around elscreen-plus (message &optional sec))
  (when message
    (unless elscreen-plus-last-message
      (setq elscreen-last-message message))
    (message "%s" message)
    (sit-for (or elscreen-plus-wait-second sec 3)))
  (message ""))
(ad-activate 'elscreen-message)

(defun elscreen-plus (&optional prefix-arg)
  (interactive "P")
  (let ((resize-minibuffer-mode t)
	last-command-char command)
    (let ((elscreen-plus-last-message t)
	  (elscreen-plus-wait-second 5))
      (elscreen-show-list)
      (setq last-command-char (read-char)))
    (setq command
	  (cdr (assq last-command-char elscreen-plus-map-alist)))
    (if command
	(call-interactively command)
      (message "ElScreen-PLUS: %s is undefined."
	       (char-to-string last-command-char)))))

(defun elscreen-find-file-read-only (filename)
  (interactive "FFind file read only in new screen: ")
  (elscreen-get-screen-create (find-file-noselect filename))
  (toggle-read-only 1))

;; from http://pure.fan.gr.jp/simm/ms/?20020824#200208242
(defun elscreen-execute-extended-command (&optional prefix-arg)
  (interactive "P")
  (if (>= (elscreen-get-open-screens) 10)
      (elscreen-message "Can't create any more screen")
    (setq this-command
	  (read-command "Run command in new screen: "))
    (elscreen-create)
    (call-interactively this-command t)))

(provide 'elscreen-plus)
