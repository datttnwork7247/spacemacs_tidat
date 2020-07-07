;;; packages.el --- Erlang Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq erlang-packages
      '(
        company
        erlang
        ;; flycheck
        edts
        (erl-trace :location (recipe
                              :fetcher github
                              :repo "datttnwork7247/erl-trace"
                              :file ("*")))
        (cmpload :location (recipe
                            :fetcher github
                            :repo "datttnwork7247/cmpload"
                            :file ("*")))
        ))
;; INIT
(defun erlang/init-erlang ()
  (use-package erlang
    :defer t
    :init
    (progn
      (add-hook 'erlang-mode-hook 'spacemacs/run-prog-mode-hooks)
      (with-eval-after-load 'auto-highlight-symbol
        (add-to-list 'ahs-plugin-bod-modes 'erlang-mode))
      (setq erlang-compile-extra-opts '(debug_info)))
    :config
    (require 'erlang-start)))

(defun erlang/init-erl-trace ()
  :defer t
  :init
  (use-package erl-trace))

(defun erlang/init-cmpload ()
  :defer t
  :init
  (use-package cmpload))

(defun erlang/init-edts ()
  (use-package edts
    :defer t
    :init
    (progn
      (when edts-auto-start-minor-mode
        (add-hook 'after-init-hook (lambda () (require 'edts-mode)))))
    :config
    (spacemacs/declare-prefix-for-mode 'erlang-mode "mn" "navigate")
    ))

;; Post INIT
(defun erlang/post-init-company ()
  (add-hook 'erlang-mode-hook 'company-mode))

(defun erlang/post-init-edts ()
  (unless (ignore-errors (require 'edts-start))
    (warn "EDTS is not installed in this environment!")))
;; (add-hook 'erlang-mode-hook 'edts-mode)

;; (defun erlang/post-init-edts ()
;;   (unless (ignore-errors (require 'edts-start))
;;     (warn "EDTS is not installed in this environment!")))
;; (add-hook 'after-init-hook 'my-edts-after-init-hook)

;; (defun erlang/post-init-flycheck ()
;;   (spacemacs/add-flycheck-hook 'erlang-mode))
