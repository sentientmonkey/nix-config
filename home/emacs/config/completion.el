;; Vertico: vertical completion UI
(use-package vertico
  :config
  (vertico-mode))

;; Orderless: fuzzy/out-of-order matching
(use-package orderless
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-overrides
        '((file (styles basic partial-completion)))))

;; Marginalia: annotations in the completion list
(use-package marginalia
  :after vertico
  :config
  (marginalia-mode))

;; Consult: the search/navigation commands
;; C-p = find files, C-s = ripgrep, ,fb = buffers, ,fh = info
(use-package consult
  :config
  (evil-define-key 'normal 'global (kbd "C-p")        'consult-fd)
  (evil-define-key 'normal 'global (kbd "C-s")        'consult-ripgrep)
  (evil-define-key 'normal 'global (kbd "<leader>fb") 'consult-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>fh") 'consult-info))
