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
;; 3. (At least once) Press "M-x org-roam-db-sync" to create org-roam.db.

((nil . ((eval . (setq-local
                  org-roam-directory (expand-file-name (locate-dominating-file
                                                        default-directory ".dir-locals.el"))))
         (eval . (setq-local
                  org-roam-db-location (expand-file-name "org-roam.db"
                                                         org-roam-directory)))
         (eval . (org-roam-db-sync)))))
