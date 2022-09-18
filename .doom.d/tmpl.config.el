;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;;(setq user-full-name ""
;;      user-mail-address "")

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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

;; CUSTOM IN GENERAL
;; https://www.victorquinn.com/emacs-prevent-autosave-mess
;; http://xahlee.info/emacs/emacs/emacs_set_backup_into_a_directory.html
(setq auto-save-default nil)
;; Enables local variables.
;;(setq-default enable-local-variables t)
;; Disables trailing timestamp, etc on publishes.
;; https://orgmode.org/manual/HTML-preamble-and-postamble.html
(setq org-html-postamble nil)

;; CUSTOM FOR ORG-ROAM
;; https://youtu.be/AyhPmypHDEw?t=1244
(use-package org-roam
  :ensure t
  :init
  ;; fix link display in org-roam backlinks buffer
  ;; https://www.reddit.com/r/OrgRoam/comments/x12sl6/comment/imdzvwz/
  (setq org-fold-core-style "overlays")
  (setq org-roam-v2-ack t)
  (setq org-roam-mode-sections
      '((org-roam-backlinks-section :unique t)
        org-roam-reflinks-section))
  (setq org-publish-project-alist
      '(("roam"
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "Index"
         :base-directory "{{ROAM_DIR}}"
         :publishing-function org-html-publish-to-html
         :publishing-directory "{{ROAM_DIR}}/output-html"
         :section-numbers nil
         :with-author nil
         :with-toc nil
         :html-head "<link rel=\"stylesheet\" href=\"./style.css\" type=\"text/css\"/>")))
  :custom
  (org-roam-directory "{{ROAM_DIR}}")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  ;; https://www.orgroam.com/manual.html#org_002droam_002dprotocol
  (require 'org-roam-protocol)
  ;; Adds support for roam nodes as links.
  (require 'org-roam-export)
  (org-roam-db-autosync-mode))

;; https://org-roam.discourse.group/t/export-backlinks-on-org-export/1756/21
(defun collect-backlinks-string (backend)
  (when (org-roam-node-at-point)
    (let* ((source-node (org-roam-node-at-point))
           (source-file (org-roam-node-file source-node))
           (nodes-in-file (--filter (s-equals? (org-roam-node-file it) source-file)
                                    (org-roam-node-list)))
           (nodes-start-position (-map 'org-roam-node-point nodes-in-file))
           ;; Nodes don't store the last position, so get the next headline position
           ;; and subtract one character (or, if no next headline, get point-max)
           (nodes-end-position (-map (lambda (nodes-start-position)
                                       (goto-char nodes-start-position)
                                       (if (org-before-first-heading-p) ;; file node
                                           (point-max)
                                         (call-interactively
                                          'org-forward-heading-same-level)
                                         (if (> (point) nodes-start-position)
                                             (- (point) 1) ;; successfully found next
                                           (point-max)))) ;; there was no next
                                     nodes-start-position))
           ;; sort in order of decreasing end position
           (nodes-in-file-sorted (->> (-zip nodes-in-file nodes-end-position)
                                      (--sort (> (cdr it) (cdr other))))))
      (dolist (node-and-end nodes-in-file-sorted)
        (-let (((node . end-position) node-and-end))
          (when (org-roam-backlinks-get node)
            (goto-char end-position)
            ;; Add the references as a subtree of the node
            (setq heading (format "\n\n%s References\n"
                                  (s-repeat (+ (org-roam-node-level node) 1) "*")))
            (insert heading)
            (setq properties-drawer ":PROPERTIES:\n:HTML_CONTAINER_CLASS: references\n:END:\n")
            (insert properties-drawer)
            (dolist (backlink (org-roam-backlinks-get node :unique t))
              (let* ((source-node (org-roam-backlink-source-node backlink))
                     (properties (org-roam-backlink-properties backlink))
                     (outline (when-let ((outline (plist-get properties :outline)))
                                  (mapconcat #'org-link-display-format outline " > ")))
                     (point (org-roam-backlink-point backlink))
                     (text (s-replace "\n" " " (org-roam-preview-get-contents
                                                (org-roam-node-file source-node)
                                                point)))
                     (reference (format "%s [[id:%s][%s]]\n%s\n%s\n\n"
                                        (s-repeat (+ (org-roam-node-level node) 2) "*")
                                        (org-roam-node-id source-node)
                                        (org-roam-node-title source-node)
                                        (if outline (format "%s (/%s/)"
                                        (s-repeat (+ (org-roam-node-level node) 3) "*") outline) "")
                                        text)))
                (insert reference)))))))))
(add-hook 'org-export-before-processing-hook 'collect-backlinks-string)
