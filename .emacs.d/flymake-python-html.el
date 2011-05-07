(defun flymake-html-init ()
(let* ((temp-file (flymake-init-create-temp-buffer-copy
                   'flymake-create-temp-inplace))
       (local-file (file-relative-name
		    temp-file
		    (file-name-directory buffer-file-name))))
  (list "tidy" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.html$\\|\\.ctp" flymake-html-init))

(add-to-list 'flymake-err-line-patterns
	     '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
	       nil 1 2 4))
    (push '(".+\\.xsl$" flymake-xml-init) flymake-allowed-file-name-masks)
(add-hook 'xsl-mode-hook
	      (lambda () (flymake-mode t)))
(defun flymake-pyflakes-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
             'flymake-create-temp-inplace))
     (local-file (file-relative-name
          temp-file
          (file-name-directory buffer-file-name))))
    (list "pyflakes" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
         '("\\.py\\'" flymake-pyflakes-init))
(add-hook 'python-mode-hook
	      (lambda () (flymake-mode t)))
(add-hook 'html-mode-hook
	  (lambda () (flymake-mode t)))