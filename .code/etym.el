;;; etym.el --- Lingua translucent. -*- emacs-lisp -*-

;; Copyright (C) 2007->oo  Personal Sovereignty Foundation, Inc.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.


;;; INTRODUCTION
;; Communication can be meaningful when Term Definitions are known.
;; But Term Definitions vary across context, interpretation, and time.
;; The Term Definitions of a writer may differ from those of a reader.

;; A Writer may wish he could 'link' a Term to HIS Definition,
;; But those links cannot be enforced at the time of reading.

;; A Reader guesses the intent of each ambiguous Term and then
;; 'links' that Term in his mind to his own Definition.

;; This fragile system requires Writers pay attention to possible
;; ambiguities if they want to avoid misinterpretation.  And even
;; then, Term->Definition links are neither absolute nor static.

;; It is the *Reader* who creates the links, even if 'incorrect'.

;; Traditional Wikis use []'s, _'s or CamelCase attempting to 'force'
;; the Reader into using the Definitions proposed by that Writer.

;; This is unnatural as compared to traditional communication as
;; described above.

;; etym.el ignores any attempts of 'forced' linking, and instead
;; allows each Reader to interpret the text in their own way.


;;; FEATURES
;; Markup is inherently WYSIWYG because rendered Output must equal text Input.

;; A 'Term' is the title, concept or name being defined.
;; A 'Term' may be a part of a word, a full word, or even a multiword phrase.
;; A 'Term' is created whenever a file is created.

;; The 'Definition' of a Term is the contents of it's associated file.
;;  When a Term is used within the Definition of another Term, links appear in the rendered output for each Term encountered.

;;  Other Terms are defined by regular expressions to link URLs, UNC paths etc.
;;  Shorter Titles clump ideas ~ making bigger buckets.
;;  Longer Titles are more specific to avoid unwanted connections.


;;; MARKUP
;; All whitespace and structuring must be preserved.

;; = Header1
;; == Header2
;; === Header3
;; ==== Header4

;; $ shell command
;; : bullet
;; * bullet
;; + bullet
;; . bullet

;; > quote

;;; The following may appear anywhere on a line:
;; >> quote2
;; >>> quote3
;; "'quote'"

;; /* comment */
;; ;; comment

;; (parenthetic)
;; {parenthetic}
;; [parenthetic]

;; \\UNC-Server\Shared_Folder
;; "\\UNC-Server\Shared Folder"
;; ~/LocalFile
;; ./LocalFile
;; ../LocalFile


;; Implicit URLs
;; see `etym-implicit-HTTP'

;; Explicit URLs
;; [file|https?|ftp]://anything


;;; INSTALLATION
;; Try something like this in your .emacs:

;; (autoload 'etym-mode "~/etym/.code/etym.el" "etym" t)
;; (setq auto-mode-alist'
;;    (append
;;     '((".*/etym/.text/.*" . etym-mode))
;;     auto-mode-alist))

;; Now create some text documents such as:
;;    ~/etym/.text/cost
;;    ~/etym/.text/price
;;    ~/etym/.text/profit

;;  Main entry points are `etym', `etym-mode', `etym-make-page'
;;  `etym-dired-make-marked-pages' and `etym-clean'

;;  In `etym-mode': RET or `mouse-2' at beginning of term visits that file.

;; `etym-mode' keys:
;; f5       `etym-mode-rebuild-mode'
;; C-cC-c   `etym-make-page'
;; C-cC-p   preview generated HTML of this source file
;; RET      Follow link
;; C-m      Insert line-feed (\n)


;;; IDEAS, TODO, BUGS
;;  This should recurse directories.
;;  This implementation is very poor performance.
;;  Many things don't work, or do the wrong thing.

;; LEFT-CLICK: Position Cursor
;; DOUBLE-CLICK: Default verb (such as "Open").
;; RIGHT-CLICK: Menu with other verbs (such as "Edit", "Mail", "Compress", ...)

;;  Comma separated list appearing after "^Related:" in header should resolve to this file unless they already have their own file.
;;  _underline_
;;  *bold*
;;  /italic/

;;  Investigate SplitBrain.org (DokuWiki) and pmWiki.org
;;  Inline thumbnail when URL ends in [jpg|png|gif] by writing to local dir under ../.cache/SomeSite.com/SomeDirectory/images/SomeImage.jpg
;;  BUG: regular-expression-too-large after ~ 1500 terms
;;  REG_ESIZE, /* Compiled pattern bigger than 2^16 bytes.  */

;;  Point to files in non-etym directories...  What I mean is: The use
;;    case I'm after is a way to distribute free content in an
;;    automated way..so that running etym at the top of a directory of
;;    music, video, games, etc. would expose the most valuable things
;;    in a clean way.  For games [for instance] this would probably
;;    include files and directories such as: README, ABOUT, LICENSE,
;;    COPYING, AUTHORS, CHANGES, ChangeLog, INSTALL, NEWS, manual/,
;;    doc/, src/.  Somewhat separately I want the ability to
;;    transparently install the file to local disk from a compressed
;;    source - even from the internet...  For instance: Let's say our
;;    directory tree includes an uncompressed copy of specific version
;;    of "Cannon Smash".  During the page generation, "csmash.exe" is
;;    linked to a runtime script (maybe JavaScript or a shell script)
;;    that will check whether or not the game is installed.  If not,
;;    you are prompted to allow install.  Install may copy a file from
;;    CD or DVD, or it might pull from a web address.  It then
;;    decompresses csmash-0.6.6.tar.gz and runs "csmash.exe".
;;    This is related to GNUnix, GNUin, MinEmacs and MiniMacs.

;; CGI:
;;    `open-network-stream-server'
;;    The "| edit |" menu entry sends request.
;;    We reply with large <input> field and `Save' button.
;;    The `Save' button POSTs changes.
;;    `etym-save-page' calls "vc commit <file>"
;;    then runs `etym-make-page'

;;  Try various prefixes and suffixes
;;    (un)lock(ed|ing|s|) clos(ed|ing|s|e)
;;    (blue|rasp|elder|logan)[ ]?berr(y|ies)
;;  Synonyms, antonyms, a thesaurus? etymology?
;;  Cookie backed stylesheet selection.
;;  Append backlinks (list of pages on which this term appears).

;; How to 'render' binary files in a manner fitting to their type.


;;; VERSION:
;; .13 reverted to using `interpreter-minor'.
;;   Many more markups available
;; .12 removed `interpreter-minor' dependency.
;;   `etym-mode' is now a minor mode, but not working.
;;   Headers and single-line comments ~working.
;; .11 trying to add fn calls to parse routines so I can end some markup at \n
;; .10
;;   Must specify http:// to allow URL with special chars or beginning with numeral.
;;   Local pathnames work to some degree.
;;   External links are marked class="ext" and differentiated in preferred.css
;; .09
;;   Added local pathnames.  Still no CGI write access.  Perusing new version of htmlize.el
;; .08
;;   If first line begins "Related:", the comma separated list of terms resolve to this file unless they already have their own file.  Just kidding, this isn't done.
;; .07
;;   Bug added: (subtract-time (current-time) etym-started) always returns < 1hr.
;;   Bug added: I had been using `time-subtract', but it is gone now?
;; .06
;;   `time-stamp' now working to some degree
;;   still not processing ".etym" file and `etym-input-dirs' specified there.
;; .05
;;   Match only if at beginning of word for terms less-than `etym-shortest-inner'
;;   Trying to become recursive and point to binaries
;; .04
;;   Changed directory layout to shorten URLs
;;   Other things I don't remember
;; .03
;;   tried to fix <cite> stuff, but don't understand UNICODE chars well enough...
;;   (concat "http://www.google.com/search?q=" term)
;; .02
;;   use `file-newer-than-file-p' for incremental make
;; .01 new


;;; RELATED
;; Lisperati.com/tagging.html
;; RTFM.ETLA.org/emacs/htmlfontify
;; Fly.srk.fer.hr/~hniksic/emacs/htmlize.el
;; EmacsWiki.org/emacs/LinkdMode
;; EmacsWiki.org/emacs/EevMode
;; Princeton.edu/~gdetre/software/freex
;; howm.SourceForge.jp >>howm: Write fragmentarily and read collectively.
;; CodeRay.RubyChan.de >>$ svn co http://svn.rubychan.de/coderay/trunk coderay
;; TreeTop.RubyForge.org >>Treetop is a language for describing languages. Combining the elegance of Ruby with cutting-edge parsing expression grammars, it helps you analyze syntax with revolutionarily ease.


;;; CUSTOMIZATIONS:
(defcustom etym-global-page-title nil "Title of _all_ generated pages.  If set to `nil' the title is the name of the input file.")
(defcustom etym-output-dir ".." "where to write the output")
(defcustom etym-img-dir ".data" "where <img> content is located")
(defcustom etym-default-stylesheet ".code/preferred.css" "stylesheet")

(defcustom etym-host-mail "AGNUcius@Gmail.com" "mail address to send edits")

(defcustom etym-shortest-inner
  ;; 3 ;to many inner matches
  4 ;not enough prefix coverage
  "Shortest term to match _within_ other terms.
All terms less than this match only at the beginning of words (using `\\b')")

(defcustom etym-encoding "UTF-8" ;"ISO-8859-1"
  "XML encoding attribute")



;;; CODE:
(require 'time-date)
(require 'interpreter-minor)

;; The following effect only `font-lock'
;; KLUDGE: see `etym-build-mapping' for HTML regexps

;; (defconst etym-local-*nix-path
;;   ;; ../ or ./ followed by anything but |, >, or whitespace
;; ;;  "\\(\\.\\./\\|\\./\\|/\\)[^|> \t\n\r]*"
;; ;;"\\(\\.\\./\\|\\./\\)[^|> \t\n\r]*"
;;   "/[^]):,;? \t\n\r]+"
;;   "Path on local hard drive")

(defconst etym-quoted-local-M$-path
  "\"\\([a-zA-Z]:\\\\.+?\\)\""
  "Quoted path on local hard drive")

(defconst etym-local-M$-path
  ;;"\\\\[^\\\\].+?[^]):,;? \t\n\r]+"
  "[a-zA-Z]:\\\\[^]):,;? \t\n\r]+"
  "Path on local hard drive")

(defconst etym-quoted-UNC-path
  "\"\\(\\\\\\\\[^]:?]+?\\)\""
  "Quoted UNC")

(defconst etym-UNC-path
  "\\\\\\\\[^]):,;? \t\n\r]+"
  "UNC path on MS network")

(defconst etym-explicit-URL
;;  "\\(file\\|ftp\\|https?\\)://[^ \t\n\r]+"
  "\\([a-zA-Z0-9]\\)+://[^ \t\n\r]*"
  "Specify protocol to include chars banned from implicit-HTTP.")

(defconst etym-implicit-HTTP
;;   "\\([a-zA-Z][a-zA-Z0-9_-]*\\.[a-zA-Z0-9-_]+\\)[^])}>:,; \t\n\r]+"
  "\\(\\([a-zA-Z0-9_-]\\)+\\.\\)+\\(aero\\|am\\|at\\|au\\|be\\|biz\\|ca\\|cat\\|cc\\|ch\\|com\\|coop\\|cx\\|cz\\|da\\|de\\|dk\\|edu\\|es\\|eu\\|fi\\|fr\\|gov\\|hu\\|ie\\|il\\|im\\|in\\|it\\|info\\|int\\|jp\\|jobs\\|lt\\|me\\|mil\\|mobi\\|museum\\|name\\|net\\|nl\\|no\\|nu\\|nz\\|org\\|pl\\|pro\\|pt\\|ro\\|ru\\|se\\|si\\|sk\\|tel\\|to\\|travel\\|tv\\|uk\\|us\\|ws\\|za\\)[^])}>:,; \t\n\r]*"
;;maybe use `regexp-opt' here?
  "Characters ])}>:,; \\t\\r\\n end the implicit HTTP URL.")


(defvar etym-mapping nil)
(defvar etym-input-dirs '("."))
(defvar etym-closing nil)

(defun etym-shortest-inner (term)
  (if (< (length term) etym-shortest-inner)
	  (if (<= (length term) 2)
		  (concat "\\b" (regexp-quote term) "\\b") ;;find tiny terms only if they stand alone
		(concat "\\b" (regexp-quote term))) ;;find short terms only at beginning of word
	(regexp-quote term)))					 ;;Term otherwise

;;This doesn't really recurse yet, but it really should be a collection of files and directories to allow posting of .files etc.
(defun etym-recurse (process-file)
  (mapcar
   (lambda (term)
     (if (not (file-directory-p term))
         (funcall process-file term)))
   ;; longer terms take precedence
   (sort (directory-files ".")
         (lambda (x y)
           (< (length x) (length y))))))

;; ;; call `process-file' on each file in dir
;; (defun etym-recurse (dir process-file)
;;   (mapcar
;;    (lambda (term)
;;      (if (not (file-directory-p term))
;;          (funcall process-file  dir term)
;; 	   ;;else
;; 	   (etym-recurse (concat dir "\\" term) process-file)))
;;    ;; create list of all files in directory sorted so terms have precedence
;;    (sort (directory-files dir)
;;          (lambda (x y)
;;            (< (length x) (length y))))))

(defun etym-clean ()
  "like \"make clean\""
  (interactive)
  (shell-command (concat "rm " etym-output-dir "/*.htm")))

(defun etym-build-mapping ()
  (setq etym-mapping nil)

  ;;the longest file name has the highest priority
  ;;  (etym-recurse (file-name-directory (expand-file-name "."))
  (etym-recurse
   (lambda (file)
     (setq etym-mapping
           (cons
			(list
			 (etym-shortest-inner file)
			 (concat
			  "<a href=\"" file ".htm"
;; 			  (if (file-name-extension file)
;; 				  nil
;; 				".htm")
				   "\">\\&</a>"))
                 etym-mapping))))

  (dolist
	  (term
	   '(
		 ;;The first entry here has LOWEST priority.
		 ;;must appear at BOL
;;   		 ("^.[^ \n\r\t]+?:" "<span class=\"type\">\\&" "</span>")

;;  		 ("^.*?:" "<span class=\"h4\">\\&" "</span>");anything followed by a : is a title?

 		 ;;see `etym-*nix-path'
;; 		 ("\\(/\\|\./\\|\.\./\\)[^]):,;? \t\n\r]+"
;; 		  "<a class=\"ext\" href=\"file:///\\&\">\\&</a>")

 		 ("^Related:" "<span class=\"rel\">\\&</span>")
		 ;;("^Related:" "<span class=\"rel\">\\&" "</span>")
 		 ("^[a-z]\\{3\\}-[0-9]\\{1,2\\}-[0-9]\\{2,4\\}:" "<hr/><span class=\"date\">\\&</span>")
 		 ("^>" "<span class=\"quot\">\\&" "</span>")

 		 ("^=" "<span class=\"h1\">\\&" "</span>")
 		 ("^==" "<span class=\"h2\">\\&" "</span>")
 		 ("^===" "<span class=\"h3\">\\&" "</span>")
 		 ("^====" "<span class=\"h4\">\\&" "</span>")

 		 ("^\\$ " "<span class=\"shell\">\\&" "</span>")

		 ;;("^[ \t]*\\([0-9]\\|[A-Z]\\|[a-z]\\)+\\(\\.\\|:\\)$" "<span class=\"bullet\">\\&</span>")

 		 ("^[ \t]*\\(:\\|\\*\\|\\+\\|\\.\\)" "<span class=\"bullet\">\\&</span>")
;; 		 ("^[ \t]*:" "<span class=\"indent\">\\&</span>")

 		 ("^::" "<span class=\"cmnt\">\\&" "</span>") ;;Batch-file comments
;;  		 ("^REM" "<span class=\"cmnt\">\\&" "</span>") ;;Batch-file comments

 		 ("(\\|{\\|\\[" "<small>\\&")
 		 (")\\|\\}\\|]" "\\&</small>")

 		 ("\"'" "<span class=\"quot\">\\&")
 		 ("'\"" "\\&</span>")

 		 ;; ("/\\*" "<span class=\"cmnt\">/*")
 		 ;; ("\\*/" "*/</span>")

;;italic
;; 		 ("//[^ \t\r\n]+?//" "<span class=\"italic\">\\&" "</span>")
;;bold

		 ;;This is not correct.  We should emit to align at column mod(4)
		 ;;Wikipedia.org/wiki/Tab_key#Tabs_in_HTML
		 ("\t" "&nbsp;&nbsp;&nbsp;&nbsp;") ;;TAB
;; 		 ("\t" "\t") ;;doesn't align
;; 		 ("\t" "&#09;") ;;same as \t
;; 		 ("\t" "&#11;") ;;disallowed in SGML (HTML) and XML 1.0

		 ("  " "&nbsp;&nbsp;")
		 ("^ " "&nbsp;")

		 ;;remote images
;; 		 ("\\(ftp\\|https?\\)://[^ \t\n\r]*\\.jpg"
;; 		  (etym-cache-and-inline-image "\\&"))
;; 		 ("\\(ftp\\|https?\\)://[^ \t\n\r]+?\\(jpg\\|gif\\|png\\)" "<img src=\"\\&\" alt=\"\\&\"/>")

		 ;;("#" "<span class=\"cmnt\">\\&" "</span>")

  		 (";;" "<span class=\"cmnt\">\\&" "</span>")
 		 (">>" "<span class=\"quot2\">\\&" "</span>")
 		 (">>>" "<span class=\"quot3\">\\&" "</span>")

		 ;;KLUDGE: how do I expand these vars here?

		 ;;see `etym-quoted-local-M$-path'
		 ("\"\\([a-zA-Z]:\\\\.+?\\)\""
		  "<a class=\"ext\" href=\"file:///\\1\">\\&</a>")

;; ;; 		 ;;see `etym-local-*nix-path'
;; 		 ("/[^]):,;? \t\n\r]+"
;; ;; 		 ("\\(\\.\\./\\|\\./\\|/\\)[^|> \t\n\r]*"
;;  		  ;;"<a class=\"ext\" href=\"file:///\\&\">\\&</a>")
;; 		  "<a class=\"ext\" href=\"\\&\">\\&</a>")

		 ;;("//" "<span class=\"cmnt\">\\&" "</span>") ;;c++ comment pattern may conflict with markup to indicate files, URLs, and/or italics


;; 		 ;;see `etym-local-M$-path'
		 ("[a-zA-Z]:\\\\[^]):,;? \t\n\r]+"
		  "<a class=\"ext\" href=\"file:///\\&\">\\&</a>")

		 ;;see `etym-quoted-UNC-path'
		 ("\"\\(\\\\\\\\[^]:?]+?\\)\""
		  "<a class=\"ext\" href=\"file:///\\1\">\\&</a>")

		 ;;see `etym-UNC-path'
		 ("\\\\\\\\[^]):,;? \t\n\r]+"
		  "<a class=\"ext\" href=\"file:///\\&\">\\&</a>")

		 ;;TODO: encode & to &amp;
		 ;;see `etym-explicit-URL'
		 ("\\([a-zA-Z0-9]\\)+://[^ \t\n\r]*"
;; 		 ("\\(file\\|ftp\\|https?\\)://[^ \t\n\r]+"
;; 		  `(replace-regexp-in-string
;; 		   "\\&" ;replace ampersand
;; 		   "\\&amp;" ;with it's entity
;; 		   "<a class=\"ext\" href=\"\\&\">\\&</a>"))
		   "<a class=\"ext\" href=\"\\&\">\\&</a>")
		 ;;see `etym-implicit-HTTP'
		 ;;("\\([a-zA-Z][a-zA-Z0-9_-]*\\.[a-zA-Z0-9-_]+\\)[^])}>:,; \t\n\r]+"
		 ("\\(\\([a-zA-Z0-9_-]\\)+\\.\\)+\\(aero\\|at\\|au\\|be\\|biz\\|ca\\|cat\\|cc\\|ch\\|com\\|coop\\|cx\\|cz\\|da\\|de\\|dk\\|edu\\|es\\|eu\\|fi\\|fr\\|gov\\|hu\\|ie\\|il\\|im\\|in\\|it\\|info\\|int\\|jp\\|jobs\\|lt\\|me\\|mil\\|mobi\\|museum\\|name\\|net\\|nl\\|nu\\|nz\\|org\\|pl\\|pro\\|pt\\|ro\\|ru\\|se\\|si\\|sk\\|tel\\|to\\|travel\\|tv\\|uk\\|us\\|ws\\|za\\)[^])}>:,; \t\n\r]*"
		  "<a class=\"ext\" href=\"http://\\&\">\\&</a>")

		 ;;XML entities
		 ("<" "&lt;")
		 ("&" "&amp;")

 		 ("<i>" "&lt;i><span class=\"itlc\">")
 		 ("</i>" "</span>&lt;/i>")

 		 ("<b>" "&lt;b><span class=\"bold\">")
 		 ("</b>" "</span>&lt;/b>")

;; 		 ("\n" "\n")

		 ;;whitespace is now preserved in preferred.css/white-space:pre-wrap
		 ("\n" "<br/>\n")
		 ("\r" "")


;;;;;;;; ---- ADD TERMS ABOVE THIS LINE ---- ;;;;;;;;
;;;;;;;; Note: Entries at the BOTTOM of this list have HIGHEST priority
		 ))
    (setq etym-mapping (cons term etym-mapping))))

(defun etym ()
  (interactive)
  (let ((etym-started (current-time)))
    (etym-gen-missing-image-files)
	;; (shell-command "ls -U -1 -t > _changes")
	;; (shell-command "ls -t --full-time -G > _changes")

    (shell-command "ls -1 > _index") ;;BUGBUG
;;    (shell-command "ls -t -1 > _changes")
    (etym-build-mapping)

    (if (not (file-exists-p etym-output-dir))
        (make-directory etym-output-dir))

;;    (etym-recurse (file-name-directory (expand-file-name "."))
    (etym-recurse
	 'etym-make-page-internal)

;;make special pages:

;;htmlize
;;  (if (file-exists-p "etym.el")
;;      (progn
;;        (htmlize-file "etym.el" etym-output-dir)
;;        (rename-file )
	;;))

	(copy-file "../.code/index.source.htm" (concat etym-output-dir "/index.htm") t)
	(copy-file "../.code/index.source.htm" (concat etym-output-dir "/index.html") t)


	;;     (message
	;;      (concat "etym finished in "
	;;              (format-time-string
	;;               "%I Hours, %M minutes, %S seconds"
	;;               (subtract-time (current-time) etym-started))))

    (message
     (concat "etym started at "
             (format-time-string
              "%I:%M:%S \n"
			  etym-started)

			 "and finished at "
             (format-time-string
              "%I:%M:%S"
              (current-time) )))))


(defun etym-make-page (file)
  (interactive "fFile: ")
  (setq file (file-name-nondirectory file))
  (etym-build-mapping)
  (etym-make-page-internal file))

(defun etym-dired-make-marked-pages ()
  (interactive)
  (etym-build-mapping)
  (dired-map-over-marks
   (etym-make-page-internal
    (file-name-nondirectory (dired-get-filename nil t))) nil))

(defun etym-make-page-internal (file)
  (let ((new-file (concat etym-output-dir "/" file))
        (process ".htm")
		;; 		 (if (file-name-extension file)
		;;                      nil
		;;                    ".html"))
		(modified (format-time-string "%B %e, %Y %l:%M %p" (nth 5 (file-attributes file)))))

    (setq new-file (concat new-file process))

    (if (file-newer-than-file-p new-file file)
        (message (concat new-file " is up to date"))

      (copy-file file new-file t)

      (if process
          (let ((found nil))
            (save-excursion)
            (set-buffer (find-file-literally new-file))
;;			(setq buffer-file-coding-system default-buffer-file-coding-system)
            (setq case-fold-search t)
            (goto-char (point-min))
            (let ((term-count (length etym-mapping)))
              (while (< (point) (point-max)) ;;while not EOF
                (let ((cur-point (point))
                      (max-point (point-max))
                      (cur-term 0)
                      (found nil))

                  (while (< cur-term term-count) ;;while more terms to consider
                    (let ((regexp (car (nth cur-term etym-mapping)))
						  (replacement (car (cdr (nth cur-term etym-mapping))))
						  (closing (cdr (cdr (nth cur-term etym-mapping)))))
                      (if (looking-at regexp)
                          (progn ;;found the term

;;if `cur-term' represents a file (not just a regexp)
;;  then add `file' to `cur-term's backlink list
;;after `etym-make-pages' is complete, iterate through all files again, appending all found backlinks

							;;if this map has a closing tag
							(if closing
								;;prepended to the current string so it closes first
								(setq etym-closing (concat (car closing) etym-closing)))

							(if (and (string= regexp "\n") ;if at EOL,
									 etym-closing);and there are tags to close,
								(progn
								  ;;close tags and follow with \n replacement
								  ;;(insert etym-closing replacement)
								  (insert etym-closing)
								  (setq etym-closing nil);empty our bucket
								  )
							  ;;else, just replace as normal
							  (replace-match replacement t nil))

                            (setq cur-term term-count) ;;break out of while
                            (setq found t)
;;`re-search-forward' already set the point to the end of the replacement text
                            )
                        (setq cur-term (+ 1 cur-term))) ;;didn't find a match, so try the next term at the same point
                      ))

                  (if (not found) ;;if no match was found
                      (forward-char))))


;;header
              (goto-char (point-min))
              (insert
			   "<?xml version=\"1.0\" encoding=\"" etym-encoding "\"?>\n"
               "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n"
               "\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n"
               "\n"
               "<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\" xml:lang=\"en\">\n"
               "\n"
               "<head>\n"
			   "  <title>"
			   (if etym-global-page-title
				   etym-global-page-title
				 file)
			   "</title>\n"

			   ;; 			   "    <script type=\"text/javascript\" src=\".code/libreria.sf.net.js\"/>\n"

			   "    <link href=\"" etym-default-stylesheet "\" rel=\"stylesheet\" type=\"text/css\"/>\n"
			   ;; 			   "<link rel=\"alternate stylesheet\" type=\"text/css\" href=\"../code/alternate.css\" title=\"alternate\"/>\n"
			   ;; 			   "<script src=\"../code/styleswitcher.js\" type=\"text/javascript\"></script>\n"

               "</head>\n"
               "\n"
               "<body>\n"
;; 			   "<div align=\"right\">\n"
			   ;; 			   "<input type=\"button\" value=\"preferred\" onclick=\"setActiveStyleSheet('preferred')\"/><br/>\n"
			   ;; 			   "<input type=\"button\" value=\"alternate\" onclick=\"setActiveStyleSheet('alternate')\"/><br/>\n"
;; 			   "</div>\n"
			   )

;;top menu
              (insert
			   (concat
;; 				"<table border=\"0\" width=\"100%\">\n"
;; 				"<tr>\n"
;; 				"<td>\n"
				"<div id=\"header\">\n"
				"<a href=\"_home.htm\">Home</a> |"
				;; " <a href=\"_news.htm\">News</a> |"
				 " <a href=\"_faq.htm\">FAQ</a> |"
				 " <a href=\"_thesis.htm\">Thesis</a> |"
				 " <a href=\"_diary.htm\">Diary</a> |"
				" <a href=\"_projects.htm\">Projects</a> |"
;;				" <a href=\"game.htm\">Game</a> |"
;;				" <a href=\"music.htm\">Music</a> |"
;;				" <a href=\"vid.htm\">Video</a> |"
;;				" <a href=\"media.htm\">Media</a> |"
				" <a href=\"_todo.htm\">Todo</a> |"
;; 				" <a href=\"_test.htm\">Test</a> |"
				" <a href=\"_index.htm\">Index</a> |"
;;				" <a href=\"_changes.htm\">Changes</a> |"
;;				" <a href=\"_about.htm\">About</a> |"
;; 				" <a href=\".off\">.off</a> |"
;; 				" <a href=\"mailto:"
;; 				etym-host-mail
;; 				"?subject=etym.edit:"
;; 				(replace-regexp-in-string
;; 				 " " "%20" file nil t)
;; 				"&amp;body=Edits are considered 'by hand' and committed every few days or weeks."
;; 				"\">Edit</a>"

;; 				"<a href=\"etym.pl?action=edit;id="
;; 				(replace-regexp-in-string " " "%20" file nil t)
;; 				"\">Edit</a>"

;; 				(insert (concat "<img src=\"" etym-img-dir "/_top.gif\" alt=\"\"/>"))
				"</div>\n"
;; 				"</td>\n"

;; 				"<form method=\"post\" action=\"etym.pl?"
;; 				(replace-regexp-in-string
;; 				 " " "%20" file nil t)
;; 				"&action=comment\">"
;; 				"<textarea name=\"comment\" cols=\"20\" rows=\"0\">Comment</textarea>"
;; 				"<input type=\"submit\" value=\"SEND\">"
;; 				"</form>"

;; 			   "  <a href=\"http://www.google.com/search?q=site%3A"
;; 			   etym-host-site
;; 			   "+%22"
;; 			   (replace-regexp-in-string
;; 				" " "+" file nil t)
;; 			   "%22\">find</a>"

;; 				"</tr>\n"
;; 				"</table>\n"
				))

			  (insert "<div id=\"main\">")

;;images
              (mapcar
               (lambda (type)
                 (if (and (file-exists-p etym-img-dir)
					 (file-exists-p
;;(concat etym-output-dir "/" etym-img-dir "/" file "." type))
					  (concat etym-img-dir "/" file "." type)))
                     (insert (concat "<img src=\"" etym-img-dir "/" file "." type "\" alt=\"\"/>"))))

               '("jpg"
                 "gif"
                 "png"))

;;footer
              (goto-char (point-max))
              (insert
			   "</div>\n"

;; 			   "<table border=\"0\" width=\"100%\">\n"
;; 			   "<tr>\n"

;; 			   "<td>\n"
;; 				"<span class=\"footer\">\n"
;; 			   " <input size=\"40\" value=\"Comments are not working yet.\"/><br/>\n"
;; 			   "</span>\n"
;; 			   "</td>\n"
;; 			   "<td style=\"text-align:right\">\n"
				"<div id=\"footer\">\n"
			   "  <a href=\".text/" file "\">Source</a> "
;;  protected by <a href=\"general public law.htm\">GNU General Public Law</a>. &nbsp;
			   "last modified: " modified
			   "</div>\n"
;; 			   "</td>\n"

;; 			   "</tr>\n"
;; 			   "</table>\n"

			   "</body>\n"
			   "</html>\n")

              (save-buffer)
              (kill-buffer (current-buffer))
              )))

	  ;;(rename-file new-file (concat new-file process) t)
	  )))


;; generate placeholders for image files that don't yet have commentary
(defun etym-gen-missing-image-files ()
  (interactive)
  (mapcar
   (lambda (file)
     (let ((f (file-name-sans-extension file)))
       (if (not (file-exists-p f))
           (progn
             (find-file f)
             (insert " ")
             (save-buffer)
             (kill-buffer (current-buffer))))))
   (directory-files (concat etym-output-dir "/" etym-img-dir))))


;;etym-mode
(defvar etym-font-lock nil)

(defun etym-build-font-lock ()
  "fill `etym-font-lock' with all terms"
  (setq etym-font-lock nil)
  (etym-recurse
   (lambda (term)
     (setq etym-font-lock
           (concat
			(etym-shortest-inner term)
			"\\|" etym-font-lock)))) ;;fill with filenames

;;encase and terminate
  (setq etym-font-lock
        (concat "\\(\\)\\("
; 				etym-local-*nix-path "\\|"
				etym-quoted-local-M$-path "\\|"
				etym-local-M$-path "\\|"
				etym-quoted-UNC-path "\\|"
				etym-UNC-path "\\|"
				etym-explicit-URL "\\|"
				etym-implicit-HTTP "\\|"
				etym-font-lock "zzzzzzzz\\)")))
;; what a mess.


(defun etym-follow ()
  (save-excursion
    (re-search-forward etym-font-lock nil t))
  (let
	  ((match (match-string 2)))
	(if match
		(progn
		  (message match)
		  (if (file-exists-p match)
			  (find-file-read-only match)
			(if (file-exists-p (capitalize match))
				(find-file-read-only (capitalize match))
			  (if (file-exists-p (upcase match))
				  (find-file-read-only (upcase match))
				(find-file-read-only (downcase match)))))))))




(defun etym-mode-rebuild-mode ()
  (interactive)
  (etym-build-font-lock)
  (im-make-mode etym "etym --- Exposing connections." etym-font-lock etym-follow)
  (etym-mode))

;; KLUDGE: etym.el needs to be rewritten as a minor mode.
(etym-mode-rebuild-mode) ;;needed so we don't get error: (void-variable etym-mode-map)

(define-key etym-mode-map [(f5)] 'etym-mode-rebuild-mode)

(defvar etym-C-c-map (make-sparse-keymap))
(define-key etym-mode-map [(control c)] etym-C-c-map)

(define-key etym-C-c-map [(control c)]
  (lambda () (interactive) "Compile this file."
    (etym-make-page buffer-file-name)))

(define-key etym-C-c-map [(control p)]
  (lambda () (interactive)
	"Browse generated HTML."
    (browse-url-of-file
;;(message
     (file-truename
      (concat
	   etym-output-dir "/"
	   (file-relative-name
		(buffer-file-name)) ".htm")))))

(provide 'etym)


;;Research:

;;http://www.emacswiki.org/cgi-bin/wiki/pp-c-l.el

;;;;AndreRiemann at http://www.emacswiki.org/cgi-bin/wiki/PrettyControlL
;;;I made something similar, but this doesn't alter the standard display table. It removes the`^L' and adds an overlay which is underlined. The overlay only shows a whole line (not only under text), if the background color of the overlay differs from the background color of the window. Maybe I later make a minor mode from this with some more options (or someone else). `after-change-major-mode-hook' is maybe not optimal?

;; (add-hook
;;  'after-change-major-mode-hook
;;  (lambda ()
;;    (font-lock-add-keywords nil
;;     `((,page-delimiter ;; variable with the regexp (usually "^\f" or "^ ")
;;         0
;;         (prog1 nil
;;           ;; don't display
;;           (compose-region (match-beginning 0) (match-end 0) "")
;;           ;; make an overlay (like in hl-line)
;;           (let ((pdl (make-overlay (line-beginning-position)
;;                                    (line-beginning-position 2))))
;;             ;; :background has to be different from the background color
;;             ;; gray1 here is just a little different from black
;;             (overlay-put pdl 'face '(:underline "gray30" :background "gray1"))
;;             (overlay-put pdl 'modification-hooks
;;                          ;; these arguments are received from modification-hooks
;;                          '((lambda (overlay after-p begin end &optional length)
;;                              (delete-overlay overlay))))
;;             (overlay-put pdl 'insert-in-front-hooks
;;                          '((lambda (overlay after-p begin end &optional length)
;;                              (delete-overlay overlay)))))) t)))))


;;; etym.el ends here
