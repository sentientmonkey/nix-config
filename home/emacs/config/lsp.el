;; Eglot is built into Emacs 29+ — language servers come from Nix packages.
;; Add a (mode . eglot-ensure) hook line and the server to home.packages
;; to enable LSP for a new language.
(use-package eglot
  :straight nil  ; built into Emacs 29+ — don't try to fetch from MELPA
  :hook
  ((sh-mode     . eglot-ensure)   ; bash-language-server
   (nix-mode    . eglot-ensure)   ; nixd
   (yaml-mode   . eglot-ensure)   ; yaml-language-server
   (python-mode . eglot-ensure)   ; needs pyright or pylsp in home.packages
   (ruby-mode   . eglot-ensure)   ; needs solargraph or ruby-lsp in home.packages
   (go-mode     . eglot-ensure))  ; needs gopls in home.packages
  :config
  (evil-define-key 'normal 'global (kbd "gd")          'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "gD")          'xref-find-definitions-other-window)
  (evil-define-key 'normal 'global (kbd "gr")          'xref-find-references)
  (evil-define-key 'normal 'global (kbd "<leader>ca")  'eglot-code-actions)
  (evil-define-key 'normal 'global (kbd "<leader>cr")  'eglot-rename)
  (evil-define-key 'normal 'global (kbd "K")           'eldoc-doc-buffer))

;; Major modes not built into Emacs
(use-package nix-mode)
(use-package yaml-mode)
