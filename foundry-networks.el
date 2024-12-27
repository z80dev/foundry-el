;;; foundry-networks.el --- Network-related utilities -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 z80
;;
;; Author: z80 <z80@ophy.xyz>
;; Maintainer: z80 <z80@ophy.xyz>
;; Created: August 02, 2024
;; Modified: August 02, 2024
;; Version: 0.0.1
;; package-requires: ((emacs "28.1"))
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/z80/foundry-networks
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Network-related utilities
;;
;;; Code:

;; display keyword as capitalized string
(defun foundry-network-name (network)
  "Return the capitalized name of NETWORK."
  (capitalize (substring (symbol-name network) 1)))


(provide 'foundry-networks)
;;; foundry-networks.el ends here
