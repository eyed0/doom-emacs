;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(package! typst-ts-mode
  :recipe (:type git :host sourcehut :repo "meow_king/typst-ts-mode"))
(package! kanagawa-theme)
  ;:recipe (:type git :host github :repo "jasonm23/emacs-theme-kanagawa"))
(package! notes-list
  :recipe (:type git :host github :repo "rougier/notes-list"))
(package! olivetti)             ;a package that simply centers the text of a buffer
(package! focus)                ;This is Focus, a package that dims surrounding text.
;(package! corfu)                ; completion
;(package! orderless)            ; orderless completion style that divides the pattern into space-separated components
(package! org-modern)           ;
(package! org-super-agenda)     ;
;(package! cape)                 ; completion at point
(package! speed-type)           ; practice typing
;(package! benchmark-init)       ; TODO benchmarks https://github.com/doomemacs/doomemacs/issues/4498
;(package! jinx)                 ; TODO spell checker - tried it but not working, need to check some time latter.
(package! yasnippet)             ;template system for Emacs.
(package! noflet)
(package! doct)
(package! svg-tag-mode)          ; A minor mode to replace keywords or regular expression with SVG tags.
;(package! org-transclusion)     ; TODO transclusion with org mode
(package! treesit-auto)          ; TODO
;(package! age)                  ; TODO encryption
;(package! wakatime-mode)        ; TODO time tracking
;(package! dape)                 ; TODO debug adpter protocol
(package! nerd-icons-corfu)      ; icons
;https://github.com/mickeynp/combobulate ;TODO
(package! org-web-tools)        ; retrieving web page content and processing it into Org-mode content.
(package! lambda-themes
  :recipe (:type git :host github :repo "Lambda-Emacs/lambda-themes"))
(package! imenu-list)           ; list current buffer's imenu entries
(package! org-roam-ql)
(package! org-roam-ui)
(package! org-roam-bibtex)
(package! org-roam-timestamps)
(package! consult-dir)
;;(package! paper-planner)
(package! monkeytype)
;;(package! outshine)           ; bring the look and feel of Org Mode to the world outside of the Org major-mode
;;(package! outline-minor-faces); This package teaches outline-minor-mode to highlight section headings
(package! mlscroll)             ; scroll bar on mode line
(package! nix-ts-mode)
;(package! enlight)              ; Dashnboard - no evil support yet, so check on this latter https://github.com/ichernyshovvv/enlight?tab=readme-ov-file
(package! binky)                ; jumping between buffers
(package! casual-info)          ; Emacs Info reader.
;(package! org-node)             ; TODO org roam alternative.
