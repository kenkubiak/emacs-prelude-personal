(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(custom-safe-themes
   '("1f6039038366e50129643d6a0dc67d1c34c70cdbe998e8c30dc4c6889ea7e3db" "2f08b4f5ff619bdfa46037553ea41f72f09013a2e6b7287799db6cec6a7dddb2" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "2dc03dfb67fbcb7d9c487522c29b7582da20766c9998aaad5e5b63b5c27eec3f" default))
 '(package-selected-packages
   '(seti-theme monokai-theme melancholy-theme use-package frontside-javascript rjsx-mode prettier-js prettier tide projectile-speedbar speedbar yaml-mode web-mode lsp-ui lsp-mode json-mode js2-mode ts-mode rainbow-mode elisp-slime-nav rainbow-delimiters company counsel swiper ivy exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens operate-on-number nlinum move-text magit projectile imenu-anywhere hl-todo guru-mode git-modes git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring anzu ag ace-window)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#24221d" :foreground "#ddd" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "apple" :family "Input Mono Narrow"))))
 '(bold ((t (:weight bold))))
 '(button ((t (:inherit link))))
 '(fixed-pitch ((t (:family "Input Mono Narrow"))))
 '(mode-line ((t (:background "#e6e5e4" :foreground "black"))))
 '(mode-line-buffer-id ((t (:foreground "firebrick4"))))
 '(mumamo-background-chunk-submode1 ((t (:background "#101820"))))
 '(tool-bar ((t (:background "grey75" :foreground "black" :box 2))))
 '(variable-pitch ((t (:family "Input Sans Narrow"))))
 '(whitespace-space ((t (:foreground "#444"))))
 '(whitespace-tab ((t (:foreground "#444")))))

;; Package setup
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.emacs.d/elpa/use-package-20221012.1743")
  (require 'use-package))

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/personal/themes/")

(use-package melancholy-theme
  :ensure t)

(use-package monokai-theme
  :ensure t)

(use-package seti-theme
  :ensure t)

(load-theme 'seti t)

;; use speedbar in the same frame
(global-set-key (kbd "s-|") 'sr-speedbar-toggle)

;; Use font Input Mono

(set-face-attribute 'default nil :font "Input Mono")
(set-frame-font "Input Mono"  nil t)
(setq-default line-spacing 0.30 )

;; Tide for TSX

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(flycheck-add-mode 'typescript-tslint 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx.*$" . web-mode))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; RJSX for JSX

;; use rjsx-mode for .js* files except json and use tide with rjsx
(add-to-list 'auto-mode-alist '("\\.js.*$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-hook 'rjsx-mode-hook 'setup-tide-mode)

;; web-mode extra config
(add-hook 'web-mode-hook 'setup-tide-mode
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))


(add-hook 'web-mode-hook 'company-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

;; SHELL and PATH for subshells
(setq explicit-shell-file-name "/bin/bash" )
(setq exec-path
      (append
       '("/Users/kk/.nvm/versions/node/v16.14.2/bin")
       exec-path))

;; Frontside Javascript
(use-package frontside-javascript
             :init (frontside-javascript))
