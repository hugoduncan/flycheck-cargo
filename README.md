# flycheck-cargo

A [flycheck][flycheck] checker for rust code, that invokes `cargo` rather than `rustc`.

## Install

Ensure `flycheck-cargo.el` is evaluated, and then enable it for your
rust buffers with something like:

```
(add-hook 'rust-mode-hook
    (lambda ()
      (setq flycheck-checker 'cargo)))
```

## Motivation

Avoiding issues like https://github.com/flycheck/flycheck-rust/issues/5.

[flycheck]: https://github.com/flycheck/flycheck "Flycheck"
