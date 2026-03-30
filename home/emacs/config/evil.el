(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  (evil-set-leader 'normal ","))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
