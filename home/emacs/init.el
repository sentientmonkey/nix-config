;; ============================================================
;; EMACS CONFIGURATION
;; ============================================================
;; Packages are managed by straight.el (below), not Nix.
;; Nix provides only the Emacs binary.
;;
;; On first launch, straight.el bootstraps itself from GitHub,
;; then installs all packages declared in config/*.el.
;; Subsequent launches load from ~/.emacs.d/straight/ (local).
;;
;; Lockfile: straight/versions/default.el — commit this to pin
;; all packages to specific commits, like lazy-lock.json in nvim.
;; Update a package: M-x straight-pull-package, then commit lockfile.
;; ============================================================


;; ── straight.el bootstrap ────────────────────────────────────
;; straight.el stores packages in ~/.emacs.d/straight/ — a runtime directory
;; it creates alongside the symlinked config files. This is fine: home-manager
;; symlinks individual files into ~/.emacs.d/, leaving the directory itself
;; writable. The lockfile at straight/versions/default.el can be committed
;; to the config repo to pin all packages, like lazy-lock.json in nvim.

;; Pinned to a specific commit — change this SHA to update straight.el itself.
;; Find the latest: https://github.com/radian-software/straight.el/commits/develop
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         user-emacs-directory))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/09b789a8596cacca6bbff866500373541a85ffa2/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package via straight and make it the default installer.
;; This means every (use-package foo) automatically installs foo via straight.
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)


;; ── Load config files ─────────────────────────────────────────
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
