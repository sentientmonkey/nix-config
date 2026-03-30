;; ============================================================
;; EMACS CONFIGURATION
;; ============================================================
;; Packages are declared in home/default.nix (programs.emacs.extraPackages)
;; and installed by Nix. This file only configures them.
;;
;; Config is split into files under config/ — each file covers
;; one concern, mirroring the lua/plugins/ layout in nvim.
;;
;; To add a new file: create config/foo.el and add a load line below.
;; ============================================================

(defun my/load (file)
  "Load FILE from the config/ subdirectory of user-emacs-directory."
  (load (expand-file-name (concat "config/" file) user-emacs-directory)))

(my/load "options")    ; editor behaviour, indentation, scrolling
(my/load "evil")       ; vim keybindings
(my/load "which-key")  ; keybinding popup
(my/load "completion") ; vertico, orderless, marginalia, consult
(my/load "lsp")        ; eglot + language modes
(my/load "ui")         ; theme, modeline, font
(my/load "org")        ; org-mode + evil-org
