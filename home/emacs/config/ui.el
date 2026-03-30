;; Theme
;; Browse alternatives with: M-x consult-theme
;; Variants: tokyonight-night, tokyonight-storm, tokyonight-moon, tokyonight-day
(use-package tokyonight-themes
  :straight (:host github :repo "xuchengpeng/tokyonight-themes")
  :config
  (load-theme 'tokyonight-storm t))

;; Modeline
(use-package nerd-icons)

(use-package doom-modeline
  :after nerd-icons
  :config
  (setq doom-modeline-height 1)
  (setq doom-modeline-column-zero-based nil)
  (setq doom-modeline-lsp t)
  (doom-modeline-mode 1))

;; Font
;; Height is in 1/10 pt — 160 = 16pt
(set-face-attribute 'default nil
                    :family "Hack Nerd Font Mono"
                    :height 160)
