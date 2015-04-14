(flycheck-def-option-var flycheck-cargo-check-tests t cargo
  "Whether to check test code in Cargo.

When non-nil, `cargo' is passed the `test' target, which will
check any code marked with the `#[cfg(test)]' attribute and any
functions marked with `#[test]'. Otherwise, `cargo' is passed
`build' and test code will not be checked.  Skipping `test' is
necessary when using `#![no_std]', because compiling the test
runner requires `std'."
  :type 'boolean
  :safe #'booleanp
  :package-version '("flycheck" . "0.20"))

(flycheck-def-option-var flycheck-cargo-crate-root nil cargo
  "A path to the crate root for the current buffer.

The value of this variable is either a string with the path to
the crate root for the current buffer, or nil if the current buffer
is a crate.  A relative path is relative to the current buffer.

If this variable is non nil the current buffer will only be checked
if it is not modified, i.e. after it has been saved."
  :type 'string
  :package-version '(flycheck . "0.20")
  :safe #'stringp)
(make-variable-buffer-local 'flycheck-cargo-crate-root)

(flycheck-define-checker cargo
  "A syntax checker for Rust code using Rust's Cargo package manager.

See URL `http://www.rust-lang.org'."
  :command ("cargo"
            (eval (if flycheck-cargo-check-tests "test" "build")))
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ": "
          (one-or-more digit) ":" (one-or-more digit) " error: "
          (message) line-end)
   (warning line-start (file-name) ":" line ":" column ": "
            (one-or-more digit) ":" (one-or-more digit) " warning: "
            (message) line-end)
   (info line-start (file-name) ":" line ":" column ": "
         (one-or-more digit) ":" (one-or-more digit) " " (or "note" "help") ": "
         (message) line-end))
  :modes rust-mode
  :predicate (lambda ()
               (or (not flycheck-cargo-crate-root) (flycheck-buffer-saved-p))))

(add-to-list 'flycheck-checkers 'cargo)
