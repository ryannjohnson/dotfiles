;; The following can be used to have different org-roams:
;; https://github.com/org-roam/org-roam/issues/1527#issuecomment-933674233
;; https://www.orgroam.com/manual.html#How-do-I-have-more-than-one-Org_002droam-directory_003f
;;
;; Place a copy of this file into the root of a new roam project, omitting
;; the "example" prefix, leaving just the ".dir-locals.el" filename.
;;
;; To load the roam workspace:
;;
;; 1. Open emacs.
;; 2. Press "SPC ." then open a file in the new roam root.

((nil . ((eval . (setq-local
                  org-roam-directory (expand-file-name (locate-dominating-file
                                                        default-directory ".dir-locals.el"))))
         (eval . (setq-local
                  org-roam-db-location (expand-file-name "org-roam.db"
                                                         org-roam-directory)))
         (eval . (setq-local
                  org-roam-output-html (expand-file-name "output-html/"
                                                         org-roam-directory)))
         (eval . (setq-local org-publish-project-alist
               `(("roam"
                  :base-directory ,org-roam-directory
                  :publishing-function org-html-publish-to-html
                  :publishing-directory ,org-roam-output-html
                  :section-numbers nil
                  :with-author nil
                  :with-toc nil
                  :html-head "<link rel=\"stylesheet\"
                             href=\"../other/mystyle.css\"
                             type=\"text/css\"/>"))))
         (eval . (org-roam-db-sync)))))
