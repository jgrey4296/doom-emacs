;;; private/hlissner/autoload/hlissner.el

;;;###autoload
(defun +hlissner/install-snippets ()
  "Install my snippets from https://github.com/hlissner/emacs-snippets into
private/hlissner/snippets."
  (interactive)
  (doom-fetch :github "hlissner/emacs-snippets"
              (expand-file-name "snippets" (doom-module-path :private 'hlissner))))

;;;###autoload
(defun +hlissner/C-u-M-x ()
  "Invokes `execute-extended-command' with the universal argument."
  (interactive)
  (let ((current-prefix-arg 1))
    (call-interactively #'execute-extended-command)))

(defmacro +hlissner-def-finder! (name dir)
  "Define a pair of find-file and browse functions."
  `(progn
     (defun ,(intern (format "+hlissner/find-in-%s" name)) ()
       ,(format "Find a file in %s" (abbreviate-file-name (eval dir)))
       (interactive)
       (let ((default-directory ,dir))
         (call-interactively (command-remapping #'projectile-find-file))))
     (defun ,(intern (format "+hlissner/browse-%s" name)) ()
       ,(format "Browse files starting from %s" (abbreviate-file-name (eval dir)))
       (interactive)
       (let ((default-directory ,dir))
         (call-interactively (command-remapping #'find-file))))))

;;;###autoload (autoload '+hlissner/find-in-templates "private/hlissner/autoload/hlissner" nil t)
;;;###autoload (autoload '+hlissner/browse-templates "private/hlissner/autoload/hlissner" nil t)
(+hlissner-def-finder! templates +file-templates-dir)

;;;###autoload (autoload '+hlissner/find-in-snippets "private/hlissner/autoload/hlissner" nil t)
;;;###autoload (autoload '+hlissner/browse-snippets "private/hlissner/autoload/hlissner" nil t)
(+hlissner-def-finder! snippets +hlissner-snippets-dir)

;;;###autoload (autoload '+hlissner/find-in-dotfiles "private/hlissner/autoload/hlissner" nil t)
;;;###autoload (autoload '+hlissner/browse-dotfiles "private/hlissner/autoload/hlissner" nil t)
(+hlissner-def-finder! dotfiles (expand-file-name ".dotfiles" "~"))

;;;###autoload (autoload '+hlissner/find-in-emacsd "private/hlissner/autoload/hlissner" nil t)
;;;###autoload (autoload '+hlissner/browse-emacsd "private/hlissner/autoload/hlissner" nil t)
(+hlissner-def-finder! emacsd doom-emacs-dir)

;;;###autoload (autoload '+hlissner/find-in-notes "private/hlissner/autoload/hlissner" nil t)
;;;###autoload (autoload '+hlissner/browse-notes "private/hlissner/autoload/hlissner" nil t)
(+hlissner-def-finder! notes +org-dir)
