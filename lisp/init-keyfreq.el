(require 'keyfreq)

(defun turnon-keyfreq-mode ()
  (interactive)
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

(defun turnoff-keyfreq-mode ()
  (interactive)
  (keyfreq-mode -1)
  (keyfreq-autosave-mode -1))

(setq keyfreq-excluded-commands
      '(self-insert-command
        abort-recursive-edit
        ace-jump-done
        ace-jump-move
        ace-window
        avy-goto-line
        backward-char
        backward-kill-word
        backward-word
        browse-kill-ring-insert-and-quit
        browse-kill-ring-forward
        browse-kill-ring-quit
        clipboard-kill-ring-save
        company-complete-common
        company-complete-number
        company-complete-selection
        company-ignore
        comint-send-input
        comint-previous-input
        delete-backward-char
        ;; {{ nothing to optimize in dired
        dired
        dired-do-async-shell-command
        dired-find-file
        diredp-next-line
        diredp-previous-line
        ;; }}
        describe-variable
        erase-message-buffer
        eval-buffer
        evil-a-WORD
        evil-append
        evil-backward-char
        evil-backward-word-begin
        evil-change
        evil-change-line
        evil-delete
        evil-delete-backward-char-and-join
        evil-delete-char
        evil-delete-line
        evil-emacs-state
        evil-end-of-line
        evil-escape-emacs-state
        evil-escape-insert-state
        evil-escape-isearch
        evil-escape-minibuffer
        evil-escape-motion-state
        evil-escape-visual-state
        evil-goto-definition
        evil-goto-mark-line
        evil-jump-backward
        evil-ex-completion
        evil-ex
        evil-ex-command
        evil-ex-delete-backward-char
        evil-exit-visual-state
        evil-exit-emacs-state
        evil-find-char
        evil-find-char-to
        evil-first-non-blank
        evil-force-normal-state
        evil-forward-char
        evil-forward-word-begin
        evil-forward-word-end
        evil-goto-first-line
        evil-goto-line
        evil-set-marker
        evil-filepath-inner-text-object
        evil-filepath-outer-text-object
        evil-inner-single-quote
        evil-inner-double-quote
        evil-inner-word
        evil-inner-WORD
        evil-paste-before
        evil-indent
        evil-insert
        evil-join
        evil-jump-forward
        evil-mc-make-and-goto-next-match
        evil-next-line
        evil-next-visual-line
        evil-normal-state
        evil-complete-previous
        evil-complete-next
        evil-repeat
        evil-open-below
        evil-paste-after
        evil-previous-line
        evil-previous-visual-line
        evil-record-macro
        evil-replace
        evil-ret
        evil-scroll-page-down
        evil-scroll-page-up
        evil-search-forward
        evil-search-next
        evil-search-word-forward
        evil-substitute
        evil-visual-char
        evil-visual-line
        evil-visual-block
        evil-yank
        exit-minibuffer
        ffip
        forward-char
        forward-word
        my-setup-develop-environment
        gnus
        gnus-summary-next-page
        gnus-summary-scroll-up
        gnus-topic-select-group
        gnus-summary-exit
        goto-line
        pwd
        ido-complete
        ido-delete-backward-updir
        ido-exit-minibuffer
        ido-switch-buffer
        indent-new-comment-line
        isearch-abort
        isearch-other-meta-char
        isearch-other-control-char
        isearch-backward-regexp
        isearch-cancel
        isearch-delete-char
        isearch-exit
        isearch-forward-regexp
        isearch-printing-char
        isearch-repeat-forward
        isearch-ring-retreat
        ispell-minor-check
        ivy-backward-delete-char
        ivy-done
        ivy-next-line
        ivy-previous-line
        js-mode
        js2-line-break
        keyboard-escape-quit
        keyboard-quit
        keyfreq-mode
        keyfreq-save-now
        keyfreq-show
        kill-sentence
        left-char
        minibuffer-complete
        minibuffer-complete-and-exit
        minibuffer-keyboard-quit
        move-beginning-of-line
        move-end-of-line
        mwheel-scroll
        newline-and-indent
        next-history-element
        next-line
        hippie-expand
        org-beginning-of-line
        org-ctrl-c-ctrl-c
        org-cycle
        org-end-of-line
        org-force-self-insert
        org-return
        org-self-insert-command
        org-todo
        package-menu-execute
        paredit-doublequote
        paredit-backward-delete
        paredit-backward-kill-word
        paredit-close-round
        paredit-newline
        paredit-open-round
        paredit-semicolon
        pcomplete
        previous-history-element
        previous-line
        push-button
        quit-window
        right-char
        save-buffer
        save-buffers-kill-terminal
        web-mode
        web-mode-jshint
        web-mode-test
        web-mode-reload
        web-mode-reveal
        web-mode-complete
        web-mode-navigate
        web-mode-surround
        web-mode-tag-beginning
        web-mode-part-beginning
        scroll-down-command
        scroll-up-command
        select-window-0
        select-window-1
        select-window-2
        select-window-3
        select-window-4
        select-window-5
        select-window-6
        select-window-7
        select-window-8
        select-window-9
        self-insert-command
        smarter-move-beginning-of-line
        suspend-frame
        term-send-raw
        turnon-keyfreq-mode
        undefined ;; lambda function
        undo-tree-redo
        undo-tree-undo
        w3m-goto-url
        w3m-next-anchor
        w3m-view-this-url
        yas-compile-directory
        yas-expand
        yas-next-field-or-maybe-expand
        yank
        ))

(unless (file-exists-p (file-truename keyfreq-file))
  (with-temp-buffer
    (insert "()")
    (write-file (file-truename keyfreq-file))))

;; And use keyfreq-show to see how many times you used a command.
;; comment out below line if there is performance impact
(turnon-keyfreq-mode)

;; Disable noisy echo message and keep silent.
(defun keyfreq-autosave--do-silent ()
  "Function executed periodically to save the `keyfreq-table' in `keyfreq-file'."
  ;; I want to exit emacs as usually even there is exception here
  (condition-case nil
      (progn
        (keyfreq-table-save keyfreq-table))
    (error
     (message "%s is corrupt" keyfreq-file))))
(advice-add 'keyfreq-autosave--do :override #'keyfreq-autosave--do-silent)

(provide 'init-keyfreq)
