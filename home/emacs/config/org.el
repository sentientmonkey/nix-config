(use-package org
  :straight nil  ; built into Emacs — don't try to fetch from MELPA
  :config
  (setq org-directory "~/org")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-src-preserve-indentation t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-capture-templates
        '(("t" "Task" entry (file+headline "~/org/tasks.org" "Tasks")
           "* TODO %?\n  %i\n")
          ("n" "Note" entry (file+headline "~/org/notes.org" "Notes")
           "* %?\n  %i\n")))
  (setq org-agenda-files (list org-directory))
  (evil-define-key 'normal 'global (kbd "<leader>oa") 'org-agenda)
  (evil-define-key 'normal 'global (kbd "<leader>oc") 'org-capture)
  (evil-define-key 'normal 'global (kbd "<leader>oo")
    (lambda () (interactive) (find-file org-default-notes-file))))

(use-package evil-org
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
