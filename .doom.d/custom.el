(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((eval setq-local org-publish-project-alist
      `(("roam" :base-directory ,org-roam-directory :publishing-function org-html-publish-to-html :publishing-directory ,org-roam-output-html :section-numbers nil :with-author nil :with-toc nil :html-head "<link rel=\"stylesheet\"
                             href=\"../other/mystyle.css\"
                             type=\"text/css\"/>")))
     (eval setq-local org-roam-output-html
      (expand-file-name "output-html/" org-roam-directory))
     (eval org-roam-db-sync)
     (eval setq-local org-roam-db-location
      (expand-file-name "org-roam.db" org-roam-directory))
     (eval setq-local org-roam-directory
      (expand-file-name
       (locate-dominating-file default-directory ".dir-locals.el"))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
