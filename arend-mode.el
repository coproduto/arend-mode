;; A simple major mode for Arend.
;; Includes only syntax highlighting for now.

(defun arend-sort-decreasing-length (list)
  (sort list
        (lambda (a b)
          (> (length a) (length b)))))

(defconst arend-keywords
  '("\\noclassifying"
    "\\classifying"
    "\\truncated"
    "\\instance"
    "\\override"
    "\\property"
    "\\default"
    "\\extends"
    "\\plevels"
    "\\hlevels"
    "\\record"
    "\\module"
    "\\hiding"
    "\\import"
    "\\infixl"
    "\\infixr"
    "\\strict"
    "\\coerce"
    "\\cowith"
    "\\alias"
    "\\axiom"
    "\\lemma"
    "\\level"
    "\\infix"
    "\\using"
    "\\where"
    "\\sfunc"
    "\\scase"
    "\\field"
    "\\peval"
    "\\have!"
    "\\this"
    "\\fixl"
    "\\fixr"
    "\\eval"
    "\\meta"
    "\\type"
    "\\cons"
    "\\open"
    "\\data"
    "\\func"
    "\\with"
    "\\elim"
    "\\have"
    "\\let!"
    "\\max"
    "\\new"
    "\\fix"
    "\\box"
    "\\use"
    "\\let"
    "\\lam"
    "\\suc"
    "\\oo"
    "\\lp"
    "\\lh"
    "\\in"
    "\\as"
    "=>"
    "->"
    ":"
    "|"
    ",")
  "List of all Arend keywords")

(defconst arend-prelude-types
  '("Nat" "Int" "=")
  "List of types and type constructors defined in the Arend Prelude")

(defconst arend-types
  (arend-sort-decreasing-length
   `("\\Sigma"
     "\\Type"
     "\\Pi"
     ,@arend-prelude-types))
  "List of all built-in Arend types and type constructors")

(defconst arend-constants
  '("_")
  "List of all Arend constants and special values")

(setq arend-keywords-regexp (regexp-opt arend-keywords 'symbols))
(setq arend-types-regexp (regexp-opt arend-types 'symbols))
(setq arend-constants-regexp (regexp-opt arend-constants 'symbols))
(setq arend-single-line-comment-regexp "--.*")

(setq arend-keywords-fontlock
      (list (cons arend-keywords-regexp 'font-lock-keyword-face)
            (cons arend-types-regexp 'font-lock-type-face)
            (cons arend-constants-regexp 'font-lock-constant-face)
            (cons arend-single-line-comment-regexp 'font-lock-comment-face)))

(defconst arend-fontlock arend-keywords-fontlock "Arend mode font-lock config")

(defconst arend-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?{ "(}1" table)
    (modify-syntax-entry ?} "){4" table)
    (modify-syntax-entry ?- "_ 23b" table)
    (modify-syntax-entry ?: "_" table)
    (modify-syntax-entry ?\\ "_" table)
    (modify-syntax-entry ?= "_" table)
    (modify-syntax-entry ?\n "> " table)
    table)
  "Custom syntax table for arend-mode")

(define-derived-mode arend-mode prog-mode "Arend"
  "major mode for editing Arend theorem prover code."
  :syntax-table arend-syntax-table
  (setq font-lock-defaults '(arend-fontlock)))
