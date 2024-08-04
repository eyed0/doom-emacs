;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "VictorMono Nerd" :size 16) ;:weight 'bold)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with theo
;; `load-theme' function. This is the default:
(setq doom-theme 'kanagawa)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; FONT
(setq doom-font (font-spec :family "SpaceMono Nerd Font" :size 19)
      doom-variable-pitch-font (font-spec :family "Atkinson Hyperlegible" :size 18))

(setq custom-file "~/.config/doom/custom.el")
(load custom-file)

(setq-default fill-column 79                          ; Default line width
              sentence-end-double-space nil           ; Use a single space after dots
              bidi-paragraph-direction 'left-to-right ; Faster
              truncate-string-ellipsis "…"            ; Nicer ellipsis
              scroll-margin 7)
(setq echo-keystrokes 0.2
      confirm-kill-emacs nil)
(pixel-scroll-precision-mode 1)

;; nicer marginalia
(setq-default marginalia--ellipsis "…"    ; Nicer ellipsis
              marginalia-align 'center     ; right alignment
              marginalia-align-offset -1) ; one space on the right

;; garbage collecction :when idle timer ser 10sec and threshold is 128mb
(setq gc-cons-threshold (eval-when-compile (* 1024 1024 128)))
(run-with-idle-timer 10 t (lambda () (garbage-collect)))

;; ;; Profile emacs startup
;; (add-hook 'emacs-startup-hook
;;           (lambda ()
;;             (message "*** Emacs loaded in %s seconds with %d garbage collections."
;;                      (emacs-init-time "%.2f")
;;                      gcs-done)))

(toggle-frame-maximized)        ;start emacs with maximized screeen

;; bookmarks
(setq bookmark-save-flag 1) ;; save bookmarks on every change
;(setq bookmark-default-file "PATH")


;; if a buffer needs to be show and it's already visible it won't be opened again in a second window
(customize-set-variable 'display-buffer-base-action
                        '((display-buffer-reuse-window display-buffer-same-window)
                          (reusable-frames . t)))

;;  Debugging Doom https://github.com/doomemacs/doomemacs/issues/4498
(when init-file-debug
  (require 'benchmark-init)
  (add-hook 'doom-first-input-hook #'benchmark-init/deactivate))

;; binky TODO check more customztions
(use-package! binky
  :hook (after-init-hook . (lambda () (binky-mode) (binky-margin-mode))))

;; Minor mode for a nice writing environment
(use-package! olivetti
  :defer t
  ;:bind (:map custom-bindings-map ("C-c o" . olivetti-mode))
  :config
  (setq-default olivetti-body-width (+ fill-column 3)))


;; Dim color of text in surrounding sections
(use-package! focus
  :defer t
  ;:bind (:map custom-bindings-map ("C-c f" . focus-mode))
  )


;; Modular text completion framework
(use-package! corfu
  :init
  (global-corfu-mode 1)
  (corfu-popupinfo-mode 1)
  :config
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-delay 0
        corfu-auto-prefix 2
        corfu-popupinfo-delay 0.5))
;; nerd icons for corfu
(add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)

;; CAPE completion at point

(use-package! cape
  ;; :defer t
  :init
  ;; (map!
  ;;  [remap dabbrev-expand] 'cape-dabbrev)
  ;; (add-hook! 'latex-mode-hook (defun +corfu--latex-set-capfs ()
  ;;                               (add-to-list 'completion-at-point-functions #'cape-tex)))
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword t)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev t)
  (add-to-list 'completion-at-point-functions #'cape-dict t)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block t)
  (add-to-list 'completion-at-point-functions #'cape-elisp-symbol t))

;; Emacs completion style that matches multiple regexps in any order
(use-package! orderless
  :config
  (setq completion-styles '(orderless basic partial-completion)
        ;completion-category-defaults nil
        ;orderless-matching-styles '(orderless-literal orderless-regexp orderless-flex)
        completion-category-overrides '((file (styles basic partial-completion)))
        orderless-component-separator "[ |]"))

;; TODO check more about temple pkg

;; Fuzzy search

(use-package! consult
  :config
  (defun consult-ripgrep-org ()
    (interactive)
    (consult-ripgrep "~/org/"))

  (map! :leader (:desc "ripgrep"
                 :prefix ("r" . "ripgrep")
                 :desc "consult-rg" :g "r" #'consult-ripgrep
                 :desc "consult-rg-org" :g "o" #'consult-ripgrep-org))
  (consult-preview-at-point-mode 1))

;; Major mode for editing .nix files
(use-package! nix-mode
  :defer t
  :hook (nix-mode . eglot-ensure))

;; TODO Scamx: A Minimalist Modal Editing Mechanism for Emacs
;; TODO https://github.com/MagiFeeney/scamx

;; TODO mode line setup
(setq doom-modeline-enable-word-count t
      doom-modeline-lsp t
      doom-modeline-irc t)

;; display battery
(display-battery-mode t)
;; Display time
(display-time-mode t)

;; Time format
(customize-set-variable 'display-time-string-forms
			'((propertize (concat dayname
					      " " 12-hours ":" minutes " " (upcase am-pm))
				      'help-echo (format-time-string "%a, %b %e %Y" now))))



;; Dashnboard



(defun custom_banner ()
  (let* (
         (banner
          '("┓┏┓┓┏┏┓┏┳┓┏┓┏┳┓┏┓┏┓"
            "┃┫ ┣┫┣┫ ┃ ┣┫ ┃ ┃┃┃┃"
            "┛┗┛┛┗┛┗ ┻ ┛┗ ┻ ┗┛┣┛"))
        (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner))
  )

 (setq +doom-dashboard-ascii-banner-fn #'custom_banner)

;; TODO org mode

(setq global-org-directory "~/org/")            ;org directory

(after! org
  :init
  (require 'ffap)
  (setq org-fold-core-style 'overlays
        org-list-allow-alphabetical t             ; have a. A. a) A) list bullets
        org-use-property-inheritance t
        org-directory global-org-directory
        org-archive-location (concat org-directory "archive/%s_archive::")
        org-attach-id-dir (concat org-directory "attach/")
        org-agenda-files (ffap-all-subdirs global-org-directory)
        bookmark-default-file (concat org-directory "bookmark/bookmarks")
        org-fold-catch-invisible-edits 'smart
        org-ellipsis " » "
        org-auto-align-tags nil
        org-tags-column 0
        org-agenda-tags-column 0
        org-pretty-entities t
        org-adapt-indentation t
        org-hide-leading-stars t
        org-hide-emphasis-markers t
        org-hide-macro-markers t
        org-startup-indented t
        org-cycle-hide-block-startup t
        org-cycle-hide-drawer-startup nil
        org-startup-folded 'content
        org-log-into-drawer t
        org-log-done 'note
        org-log-done-with-time t
        org-log-refile 'note
        org-log-repeat 'note
        org-log-redeadline 'note
        org-log-reschedule 'note
        org-id-method 'ts
        org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id
        org-deadline-warning-days 2
        org-agenda-show-outline-path 'title
        org-refile-use-outline-path 'title
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-latex-src-block-backend 'engraved
        org-todo-keywords '((sequence "TODO(t)" "|" "DONE(d@/!)" "CANC(c@/!)")))
    (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h)
    (set-popup-rules!
      '(("^\\*Org Src"
         :slot 2x0 :side right :size 0.7 :select t))))

;; ORG agenda
;; org-agenda-config
(after! org-agenda
  (setq org-agenda-files (list "~/org"))
  (setq org-agenda-window-setup 'current-window
        org-agenda-restore-windows-after-quit t
        org-agenda-show-all-dates nil
        org-agenda-time-in-grid t
        org-agenda-show-current-time-in-grid t
        org-agenda-start-on-weekday 1
        org-agenda-span 15
        ;;org-agenda-tags-column  0
        ;;org-agenda-block-separator nil
        org-agenda-category-icon-alist nil
        org-agenda-sticky t)
  (setq org-agenda-prefix-format
        '((agenda . "%i %?-12t%s")
          (todo .   "%i")
          (tags .   "%i")
          (search . "%i")))
  (setq org-agenda-sorting-strategy
        '((agenda deadline-down scheduled-down todo-state-up time-up
                  habit-down priority-down category-keep)
          (todo   priority-down category-keep)
          (tags   timestamp-up priority-down category-keep)
          (search category-keep))))

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
        (?E . 'all-the-icons-blue)))

(after! org-capture
 (require 'noflet)
  (setq org-capture-templates
       (doct `(("Todo" :keys "t"
                :icon ("home" :set "octicon" :color "cyan")
                :file "~/org/todo.org"
                :prepend t
                :headline "Inbox"
               :template ("* TODO %?"
                           "%i %a"))
               ("Agenda" :keys "a"
                :icon ("business" :set "material" :color "yellow")
                :file "~/org/agenda.org"
                :prepend t
                :headline "Inbox"
                :template ("* TODO %^{priority|[#A]|[#B]|[#C]|[#D]|[#E]} %?"
                           "SCHEDULED: %^{Schedule:}t"
                           "DEADLINE: %^{Deadline:}t"
                           "%i %a"))
               ("Note" :keys "n"
                :icon ("sticky-note" :set "faicon" :color "yellow")
                :file "~/org/notes.org"
                :template ("* *?"
                           "%i %a"))
               ;; ("This week" :keys "w"  ;;TODO https://kevinkle.in/posts/2022-02-27-org_journal/
               ;;  :icon ("calendar" :set "faicon" :color "pink")
               ;;  :type plain
               ;;  :file "~/org/journal/weekly/"
               ;;  :template "** %(format-time-string org-journal-time-format)%^{Title}\n%i%?"
               ;;  :jump-to-captured t
               ;;  :immediate-finish t)
               ("Project" :keys "p"
                :icon ("repo" :set "octicon" :color "silver")
                :prepend t
                :type entry
                :headline "Inbox"
                :template ("* %{keyword} %?"
                           "%i"
                           "%a")
                :file ""
                :custom (:keyword "")
                :children (("Task" :keys "t"
                             :icon ("checklist" :set "octicon" :color "green")
                           :keyword "TODO"
                            :file +org-capture-project-todo-file)
                           ("Note" :keys "n"
                            :icon ("sticky-note" :set "faicon" :color "yellow")
                            :keyword "%U"
                            :file +org-capture-project-notes-file)))))))

;;ORG-ROAM
(use-package! org-roam
  :custom
  (org-roam-directory "~/org/roam")
  (org-roam-dailies-directory "journal/")
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-enable)
  (org-roam-timestamps-mode t)
  ;; (org-roam-dailies-capture-templates
  ;;   '(("d" "default" entry "* %<%I:%M %p>: %?"
  ;;      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  )

;; basic org mode setup
(setq-default calendar-week-start-day 1)        ;set start of week to Monday
(setq org-enforce-todo-checkbox-dependencies t) ;you first need to check off all check boxes before the TODO
                                                ;entry can be switched to DONE.

;; disable line numbers in org mode
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; Org visual settings
;; org modern
(setq ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-fold-catch-invisible-edits 'smart
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "⭠ now ─────────────────────────────────────────────────")
(global-org-modern-mode)

;; SVG tags

(use-package! svg-tag-mode
  :commands svg-tag-mode
  :config
  (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
  (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
  (defconst day-re "[A-Za-z]\\{3\\}")
  (defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))
  (defun svg-progress-percent (value)
    (svg-image (svg-lib-concat
                (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                                  nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                (svg-lib-tag (concat value "%")
                             nil :stroke 0 :margin 0)) :ascent 'center))

  (defun svg-progress-count (value)
    (let* ((seq (mapcar #'string-to-number (split-string value "/")))
           (count (float (car seq)))
           (total (float (cadr seq))))
    (svg-image (svg-lib-concat
                (svg-lib-progress-bar (/ count total) nil
                                      :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                (svg-lib-tag value nil
                             :stroke 0 :margin 0)) :ascent 'center)))

  (setq svg-tag-tags
        `(
          ;; Org tags
          (":\\([A-Za-z0-9]+\\)" . ((lambda (tag) (svg-tag-make tag))))
          (":\\([A-Za-z0-9]+[ \-]\\)" . ((lambda (tag) tag)))
          ;; Task priority
          ("\\[#[A-Z]\\]" . ( (lambda (tag)
                                (svg-tag-make tag :face 'org-priority
                                              :beg 2 :end -1 :margin 0))))

          ;; Progress
          ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                              (svg-progress-percent (substring tag 1 -2)))))
          ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                                            (svg-progress-count (substring tag 1 -1)))))

          ;; TODO / DONE
          ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0))))
          ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0))))


          ;; Citation of the form [cite:@Knuth:1984]
          ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
                                            (svg-tag-make tag
                                                          :inverse t
                                                          :beg 7 :end -1
                                                          :crop-right t))))
          ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
                                                  (svg-tag-make tag
                                                                :end -1
                                                                :crop-left t))))


          ;; Active date (with or without day name, with or without time)
          (,(format "\\(<%s>\\)" date-re) .
           ((lambda (tag)
              (svg-tag-make tag :beg 1 :end -1 :margin 0))))
          (,(format "\\(<%s \\)%s>" date-re day-time-re) .
           ((lambda (tag)
              (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
          (,(format "<%s \\(%s>\\)" date-re day-time-re) .
           ((lambda (tag)
              (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

          ;; Inactive date  (with or without day name, with or without time)
           (,(format "\\(\\[%s\\]\\)" date-re) .
            ((lambda (tag)
               (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
           (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
            ((lambda (tag)
               (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
           (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
            ((lambda (tag)
               (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date)))))))

;; org modern
(setq org-modern-star '("❖" "∴" "∵" "∴" "∵" "∴" "∵" "∴")
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-list '((43 . "➤")
                          (45 . "–")
                          (42 . "•"))
        org-modern-footnote
        (cons nil (cadr org-script-display))
        org-modern-block-fringe nil
        org-modern-block-name
        '((t . t)
          ("src" "»" "«")
          ("example" "»–" "–«")
          ("quote" "❝" "❞")
          ("export" "⌜" "⌝"))
        org-modern-progress nil
        org-modern-priority nil
        org-modern-horizontal-rule (make-string 36 ?─)
        org-modern-keyword
        '((t . t)
          ("title" . "ぺ")
          ("subtitle" . "⟐")
          ("author" . "✎")
          ("email" . #("" 0 1 (display (raise -0.14))))
          ("date" . "◳")))

(define-skeleton my-org-file-frontmatter
  "Front matter for new org files."
  "Title: "
  "#+TITLE: " str \n
  "#+AUTHOR: " (skeleton-read "Author: " user-full-name) \n
  "#+EMAIL: " (skeleton-read "Email: " user-mail-address) \n
  "#+DATE: " '(call-interactively 'org-time-stamp) "\n\n")

(auto-insert-mode 1)

;; TODO org clock https://codeberg.org/sochotnicky/dotfiles/src/branch/main/dot_doom.d/config.org#headline-36

;; yasnippet
(use-package! yasnippet
  :config
  (setq yas-snippet-dirs '("~/org/yasnippets"))
  (yas-global-mode t))

;; treesit auto
(use-package! treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; ;; LSP and LSP UI

;; (use-package! lsp-mode
;;   :commands lsp
;;   :custom
;;   ;; what to use when checking on-save. "check" is default, I prefer clippy
;;   (lsp-rust-analyzer-cargo-watch-command "clippy")
;;   ;(lsp-eldoc-render-all t)
;;   (lsp-idle-delay 0.6)
;;   ;; enable / disable the hints as you prefer:
;;   (lsp-inlay-hint-enable t)
;;   ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
;;   (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
;;   (lsp-rust-analyzer-display-chaining-hints t)
;;   (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names t)
;;   (lsp-rust-analyzer-display-closure-return-type-hints t)
;;   (lsp-rust-analyzer-display-parameter-hints t)
;;   (lsp-rust-analyzer-display-reborrow-hints t)
;;   :config
;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; (setq lsp-inlay-hint-enable t)

;; (use-package! lsp-ui
;;   :commands lsp-ui-mode
;;   :custom
;;   (lsp-ui-peek-always-show t)
;;   (lsp-ui-sideline-show-hover t)
;;   (lsp-ui-doc-enable nil))

(mlscroll-mode 1)

(use-package! rust-ts-mode
  :mode ("\\.rs" . rust-ts-mode)
  :hook (rust-ts-mode . eglot-ensure))
