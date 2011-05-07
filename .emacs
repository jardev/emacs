(set-default-font "Consolas-11")
(add-to-list 'load-path "~/.emacs.d/")

(global-font-lock-mode 1)
(require 'color-theme)
;(setq color-theme-is-global t)
(color-theme-jsc-dark)
;(color-theme-scintilla)
(setq scroll-step 1)

(setq x-select-enable-clipboard t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(display-battery-mode t)
 '(ecb-options-version "2.32")
 '(line-number-mode 1)
 '(global-linum-mode 1)
 '(jabber-account-list (quote (("jardev@gmail.com" (:network-server . "talk.google.com") (:connection-type . ssl)))))
 '(show-paren-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(word-wrap nil))

;;;;(setq cua-enable-cua-keys nil)
(setq cua-highlight-region-shift-only t) ;; no transient mark mode
(setq cua-toggle-set-mark nil) ;; original set-mark behavior, i.e. no transient-mark-mode
(cua-mode)

(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq edit-server-new-frame nil)
(server-start)
(ido-mode 1)
(setq word-wrap nil)
(toggle-truncate-lines -1)
(auto-fill-mode -1)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(setq default-tab-width 4)
(setq sgml-basic-offset 4)

;;; bind RET to py-newline-and-indent
(add-hook 'python-mode-hook '(lambda ()
     (define-key python-mode-map "\C-m" 'newline-and-indent)))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default py-indent-offset 4)

(setq main-dir "~")
(setq em-dir "~/.emacs.d")

;; TabBar
(require 'tabbar)
(set-face-attribute
 'tabbar-default nil
 :background "gray60")
(set-face-attribute
 'tabbar-unselected nil
 :background "gray85"
 :foreground "gray30"
 :box nil)
(set-face-attribute
 'tabbar-selected nil
 :background "#f2f2f6"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
 'tabbar-separator nil
 :height 0.7)

(setq tabbar-buffer-groups-function
      (lambda ()
        (list
         (cond
          ((string= "*-jabber-"
                    (and
                     (> (length (buffer-name (current-buffer))) 8)
                     (substring (buffer-name (current-buffer)) 0 9)))
           "jabber")
          ((find (aref (buffer-name (current-buffer)) 0) " *") "*")
          ((string= "org"
                    (file-name-extension (buffer-name (current-buffer))))
           "org")
          (t "All")))))

(file-name-extension "test")
(string= "py" (file-name-extension "test.py"))

(tabbar-mode)
(global-set-key (kbd "C-`") 'tabbar-backward)
(global-set-key (kbd "C-<tab>") 'tabbar-forward)

;;; Breadcrumbs
(require 'breadcrumb)
(global-set-key [f6] 'bc-set)
(global-set-key [f7] 'bc-list)

;;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;; Django stuff
(add-to-list 'load-path "~/.emacs.d/django-mode")
(require 'django-html-mode)
(require 'django-mode)


;;; ReST
(require 'rst)
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))

;;; Markdown
(require 'markdown-mode)
(setq auto-mode-alist
      (append '(("\\.markdown$" . markdown-mode)
                ("\\.md$" . markdown-mode)) auto-mode-alist))

;;; JavaScript, yay
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

;; configure css-mode
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level '2)

;;; Yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
(yas/load-directory "~/.emacs.d/django-mode/snippets")

;;; Flymake
(require 'flymake)
;(load "flymake-python-html.el")

;;; Gettext
(require 'po-mode)
(eval-after-load 'po-mode '(load "gb-po-mode"))
(add-to-list 'auto-mode-alist '("\\.po$" . po-mode))

;;; HTML. Yeah, HTML... 5.
;(add-to-list 'load-path "~/.emacs.d/html5-el")
;(eval-after-load "rng-loc"
;  '(add-to-list 'rng-schema-locating-files (concat em-dir "/html5-el/schemas.xml")))
;(require 'whattf-dt)
;(add-to-list 'auto-mode-alist '("\\.html$" . nxml-mode))
;(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))

;;; Word counter
(defun wc ()
  (interactive)
  (message "Page has %s words" (how-many "\\w+" (point-min) (point-max))))
(global-set-key (kbd "C-x w") 'wc)


;;; FIXME/TODO/BUG/XXX highlight
(defun markers-hl ()
  (font-lock-add-keywords nil
                          '(("\\<\\(FIXME\\|TODO\\|BUG\\|XXX\\):" 1 font-lock-warning-face t))))
(add-hook 'python-mode-hook 'markers-hl)
(add-hook 'perl-mode-hook 'markers-hl)
(add-hook 'js-mode-hook 'markers-hl)
(add-hook 'css-mode-hook 'markers-hl)
;(add-hook 'nxml-mode-hook 'markers-hl)

;These lines are required for ECB
(add-to-list 'load-path "~/.emacs.d/eieio-0.17")
(add-to-list 'load-path "~/.emacs.d/speedbar-0.14beta4")
(add-to-list 'load-path "~/.emacs.d/semantic-1.4.4")
(setq semantic-load-turn-everything-on t)
(require 'semantic-load)
; This installs ecb - it is activated with M-x ecb-activate
(add-to-list 'load-path "~/.emacs.d/ecb-2.32")
(require 'ecb-autoloads)
(setq ecb-layout-name "left7")
(setq ecb-layout-window-sizes (quote (("left14" (0.2564102564102564 . 0.6949152542372882) (0.2564102564102564 . 0.23728813559322035)))))
(setq ecb-source-path (quote ("~/dev" "/")))
;(ecb-activate)
; sr-speedbar
;(require 'sr-speedbar)
;(global-set-key (kbd "s-b") 'sr-speedbar-toggle)

(add-to-list 'load-path "~/.emacs.d/Pymacs-0.23")
(require 'auto-complete)
(global-auto-complete-mode t)
(require 'virtualenv)
(load-library "init_python")

;; Highlight column 79
;(require 'column-marker)
;(add-hook 'font-lock-mode-hook (lambda () (interactive) (column-marker-1 80)))

;; Jabber
(require 'jabber)
(global-set-key "\C-x\C-a" 'jabber-activity-switch-to)

;; Default chromium browser
(setq browse-url-generic-program (executable-find "chromium-browser")
      browse-url-browser-function 'browse-url-generic)


; Show whitespace
;(require 'show-wspace)
;(add-hook 'python-mode-hook 'highlight-tabs)

(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;; Pyton outline
(add-hook 'python-mode-hook 'my-outline-python-hook)
; this gets called by outline to deteremine the level. Just use the length of the whitespace
(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (current-column))))
; this get called after python mode is enabled
(defun my-outline-python-hook ()
  ; outline uses this regexp to find headers. I match lines with no indent and indented "class"
  ; and "def" lines.
  (setq outline-regexp "[^ \t\n]\\|[ \t]*\\(def[ \t]+\\|class[ \t]+\\)")
  ; enable our level computation
  (setq outline-level 'py-outline-level)
  ; do not use their \C-c@ prefix, too hard to type. Note this overides some python mode bindings
  ;(setq outline-minor-mode-prefix "\C-c")
  ; turn on outline mode
  (outline-minor-mode t)
  ; initially hide all but the headers
  ;(hide-body)
  ; I use CUA mode on the PC so I rebind these to make the more accessible
  (local-set-key [M-right] 'py-shift-region-right)
  (local-set-key [M-left] 'py-shift-region-left)
  (local-set-key [M-up] 'hide-subtree)
  (local-set-key [M-down] 'show-subtree)
  ; make paren matches visible
  (show-paren-mode 1))

;; nxHtml
;(load "/home/jarik/.emacs.d/nxhtml/autostart.el")
;(add-to-list 'auto-mode-alist '("\\.html$" . django-nxhtml-mumamo-mode))

;; Android
(require 'android)
(add-to-list 'load-path "~/.emacs.d/android-mode")
(require 'android-mode)

(custom-set-variables
 '(android-mode-sdk-dir "/opt/android"))

;; File reloading
(defun reload-file ()
  (interactive)
  (let ((curr-scroll (window-vscroll)))
    (find-file (buffer-name))
    (set-window-vscroll nil curr-scroll)
    (message "Reloaded file")))

(global-set-key "\C-c\C-r" 'reload-file)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) nil)))
 '(mumamo-background-chunk-submode1 ((((class color) (min-colors 88) (background dark)) (:background "#1e1416"))))
 '(mumamo-background-chunk-submode2 ((((class color) (min-colors 88) (background dark)) (:background "#1e1416"))))
 '(mumamo-background-chunk-submode3 ((((class color) (min-colors 88) (background dark)) (:background "#1e1416"))))
 '(mumamo-background-chunk-submode4 ((((class color) (min-colors 88) (background dark)) (:background "#1e1416")))))


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

(autoload 'magit-status "magit" nil t)

;; Jabber notifier
(defvar jabber-libnotify-icon ""
  "*Icon to be used on the notification pop-up. Default is empty")

(defvar jabber-libnotify-timeout "2000"
  "*Specifies the timeout of the pop up window in millisecond")

(defun jabber-libnotify-message (from msg)
  "Show MSG using libnotify"
  (let ((process-connection-type nil))
    (start-process "notification" nil "notify-send"
                   "-t" jabber-libnotify-timeout
                   "-i" jabber-libnotify-icon
                   from msg)))

(defun jabber-libnotify-message-display (from buffer text propsed-alert)
  (switch-to-buffer buffer)
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (jabber-libnotify-message (format "(PM) %s"
                                          (jabber-jid-displayname (jabber-jid-user from)))
                                  (format "%s: %s" (jabber-jid-resource from) text)))
    (jabber-libnotify-message (format "%s" (jabber-jid-displayname from))
                              text)))

(defvar jabber-me "jardev")

(defun jabber-libnotify-muc-display (nick group buffer text proposed-alert)
  (let ((match (string-match jabber-me text)))
    (when match
      (when (>= match 0)
        (switch-to-buffer buffer)
        (jabber-libnotify-message (format "%s/%s" group nick) text)))))

(add-to-list 'jabber-alert-message-hooks
             'jabber-libnotify-message-display)

(add-to-list 'jabber-alert-muc-hooks
             'jabber-libnotify-muc-display)
