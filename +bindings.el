;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta))

(map!
 ;; Window Movements
 "C-h"    #'evil-window-left
 "C-j"    #'evil-window-down
 "C-k"    #'evil-window-up
 "C-l"    #'evil-window-right

 (:after clojure-mode
   (:map clojure-mode-map
     :leader
     :n "\\" #'helm-cider-apropos
     :n "DEL" #'helm-cider-apropos-ns
     (:desc "reload" :prefix "r"
       :desc "Refresh user libraries" :n "l" #'rs/user/sync-libs
       :desc "Restart Integrant" :n "r" #'rs/ig/restart
       :desc "Reload Integrant" :n "R" #'rs/ig/reset)
     :localleader
     :n "'" #'cider-jack-in
     :n "\"" #'cider-jack-in-clojurescript))
 ;; cider-mode
 (:after cider-mode
   (:map cider-mode-map
     :leader
     :desc "Lookup documentation at point" :n "d" #'cider-doc
     :desc "Jump to definition at point" :n "l" #'cider-find-var
     :localleader
     :n "b" #'cider-eval-buffer
     :n "B" #'cider-switch-to-repl-buffer
     :n "n" #'cider-repl-set-ns
     :n "j" #'cider-find-var
     :n "s" #'cider-browse-spec
     :n "S" #'helm-cider-spec-ns
     :n "l" #'cljr-move-to-let
     :n "L" #'cljr-introduce-let
     (:desc "docs" :prefix "d"
       :desc "Browse Namespace" :n "n" #'cider-browse-ns
       :desc "Browse Spec" :n "s" #'cider-browse-spec
       :desc "Load ClojureDoc" :n "d" #'cider-clojuredocs)
     :n "h" #'cider-doc
     :n "c" #'cider-repl-clear-buffer
     :n "i" #'cider-inspect-last-result
     :n "p" #'cider-eval-sexp-at-point
     :n "f" #'cider-eval-defun-at-point
     :n "t" #'cider-test-run-ns-tests
     :n "T" #'cider-test-run-test)
   (:after cider-browse-ns-mode
     (:map cider-browse-ns-mode-map
       :n "RET"       #'cider-browse-ns-operate-at-point)))

      ;; Make ESC quit all the things
      (:map (minibuffer-local-map
             minibuffer-local-ns-map
             minibuffer-local-completion-map
             minibuffer-local-must-match-map
             minibuffer-local-isearch-map)
        [escape] #'abort-recursive-edit
        "C-r" #'evil-paste-from-register)

      (:map messages-buffer-mode-map
        "M-;" #'eval-expression
        "A-;" #'eval-expression)

      (:map tabulated-list-mode-map
        [remap evil-record-macro] #'doom/popup-close-maybe)

      (:map (evil-ex-completion-map evil-ex-search-keymap read-expression-map)
        "C-a" #'move-beginning-of-line
        "C-w" #'doom/minibuffer-kill-word
        "C-u" #'doom/minibuffer-kill-line
        "C-b" #'backward-word
        "C-f" #'forward-word
        "M-z" #'doom/minibuffer-undo)

      (:after view
        (:map view-mode-map "<escape>" #'View-quit-all)))
