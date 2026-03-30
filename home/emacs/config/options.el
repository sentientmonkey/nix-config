;; ── Startup ──────────────────────────────────────────────────
(setq inhibit-startup-message t)


;; ── UI Chrome ────────────────────────────────────────────────
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(column-number-mode t)


;; ── Line Numbers ─────────────────────────────────────────────
;; t = absolute. Change to 'relative for vim-style relative numbers.
(setq display-line-numbers-type t)
(global-display-line-numbers-mode t)


;; ── Long Lines ───────────────────────────────────────────────
(setq-default truncate-lines t)


;; ── Indentation ──────────────────────────────────────────────
;; Major modes (e.g. go-mode) can override these locally.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)


;; ── Visual Guides ────────────────────────────────────────────
(show-paren-mode t)
;; (global-hl-line-mode t)  ; disabled — too visually heavy

;; Vertical line at column 100
(setq-default fill-column 100)
(global-display-fill-column-indicator-mode t)


;; ── Scrolling ────────────────────────────────────────────────
(setq scroll-margin 3)
(setq scroll-conservatively 101)


;; ── Clipboard ────────────────────────────────────────────────
(setq select-enable-clipboard t)
(setq select-enable-primary t)


;; ── Search ───────────────────────────────────────────────────
(setq case-fold-search t)


;; ── Files ────────────────────────────────────────────────────
(global-auto-revert-mode t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq vc-follow-symlinks t)


;; ── Windows / Splits ─────────────────────────────────────────
(setq split-height-threshold nil)
(setq split-window-preferred-function 'split-window-sensibly)
