;;; foundry.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 z80
;;
;; Author: z80 <z80@ophy.xyz>
;; Maintainer: z80 <z80@ophy.xyz>
;; Created: July 29, 2024
;; Modified: July 29, 2024
;; Version: 0.0.1
;; Package-Requires: ((emacs "28.1"))
;; Keywords: foundry ethereum
;; Homepage: https://github.com/z80/foundry-el
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(require 'transient)
(require 'comint)

(defcustom foundry-anvil-network-fork-url-options '(("local" . nil))
  "Alist of anvil options. Each entry is (DISPLAY-NAME . URL)."
  :type '(alist :key-type string :value-type string)
  :group 'foundry)

(defun foundry-anvil-read-fork-url (_prompt _init _hist)
  "Read fork URL with completion from `my-anvil-options'."
  (let* ((choices (mapcar #'car foundry-anvil-network-fork-url-options))
         (custom-option "Custom URL...")
         (selected (completing-read "Choose anvil option or enter custom URL: "
                                    (append choices (list custom-option))))
         (url (cond
               ((string= selected custom-option)
                (read-string "Enter URL: "))
               (t (cdr (assoc selected foundry-anvil-network-fork-url-options))))))
    (or url "")))

(transient-define-prefix foundry-anvil-launch ()
  "Launch Anvil with custom options."
  [:class transient-columns
   ["General Options"
    ("-a" "Number of Accounts" "--accounts=" :reader transient-read-number-N+)
    ("-A" "Auto-Impersonate" "--auto-impersonate")
    ("-b" "Block Time (seconds)" "--block-time=" :reader transient-read-number-N+)
    ("-h" "Hardfork" "--hardfork=" :reader (lambda (_prompt _init _hist) (read-string "Hardfork: ")))
    ("-p" "Port" "--port=" :reader transient-read-number-N+)
    ("-s" "Silent" "--silent")]
   
   ["Network Options"
    ("-c" "Chain ID" "--chain-id=" :reader transient-read-number-N+)
    ("-l" "Gas Limit" "--gas-limit=" :reader transient-read-number-N+)
    ("-g" "Gas Price" "--gas-price=" :reader transient-read-number-N+)]
   
   ["Fork Options"
    ("-u" "Fork URL" "--fork-url=" :reader foundry-anvil-read-fork-url)
    ("-n" "Fork Block Number" "--fork-block-number=" :reader transient-read-number-N+)]]

  [["Actions"
    ("l" "Launch Anvil" foundry-anvil-launch-process)
    ("s" "Save settings" transient-set)
    ("c" "Clear settings" transient-reset)
    ("q" "Quit" transient-quit-one)]
   ])

(define-derived-mode foundry-anvil-mode comint-mode "Anvil"
  "Major mode for running Anvil commands."
  (setq-local comint-process-echoes t)
  (setq-local comint-output-filter-functions
              (append comint-output-filter-functions
                      '(ansi-color-process-output
                        comint-postoutput-scroll-to-bottom)))
  (setq-local ansi-color-for-comint-mode t))

(defun foundry-anvil-launch-process ()
  "Launch Anvil process with the selected options."
  (interactive)
  (let* ((args (transient-args 'foundry-anvil-launch))
         (command (concat "anvil " (string-join args " ")))
         (buffer-name "*Anvil Output*")
         (existing-buffer (get-buffer buffer-name)))
    ;; Check if the buffer already exists and has a running process
    (when (and existing-buffer
               (get-buffer-process existing-buffer))
      (kill-buffer existing-buffer))
    (let ((buffer (get-buffer-create buffer-name)))
      (with-current-buffer buffer
        (foundry-anvil-mode)
        (erase-buffer)
        (let ((process (start-process-shell-command "anvil" buffer command)))
          (set-process-filter process 'comint-output-filter)
          (set-marker (process-mark process) (point-max)))
        (read-only-mode))
      (pop-to-buffer buffer)))
    (transient-save))

(provide 'foundry)
;;; foundry.el ends here
