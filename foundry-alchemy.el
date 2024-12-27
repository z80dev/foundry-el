;;; foundry-alchemy.el --- Alchemy-specific configuration -*- lexical-binding: t; -*-
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
;; Homepage: https://github.com/z80/foundry-alchemy
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Alchemy-specific configuration
;;
;;; Code:

(require 'foundry-networks)

(defvar foundry-alchemy-network-url-templates
  '((:ethereum . "https://eth-mainnet.g.alchemy.com/v2/%s")
    (:arbitrum . "https://arb-mainnet.g.alchemy.com/v2/%s")
    (:polygon . "https://polygon-mainnet.g.alchemy.com/v2/%s")
    (:polygon-zkevm . "https://polygonzkevm-mainnet.g.alchemy.com/v2/%s")
    (:optimism . "https://opt-mainnet.g.alchemy.com/v2/%s")
    (:astar . "https://astar-mainnet.g.alchemy.com/v2/%s")
    (:bsc . "https://bnb-mainnet.g.alchemy.com/v2/%s")
    (:starknet . "https://starknet-mainnet.g.alchemy.com/starknet/version/rpc/v0_7/%s")
    (:base . "https://base-mainnet.g.alchemy.com/v2/%s")
    (:zksync . "https://zksync-mainnet.g.alchemy.com/v2/%s")
    (:zora . "https://zora-mainnet.g.alchemy.com/v2/%s")
    (:frax . "https://frax-mainnet.g.alchemy.com/v2/%s")
    (:avalanche . "https://avax-mainnet.g.alchemy.com/v2/%s")
    (:arbitrum-nova . "https://arbnova-mainnet.g.alchemy.com/v2/%s")
    (:zetachain . "https://zetachain-mainnet.g.alchemy.com/v2/%s")
    (:blast . "https://blast-mainnet.g.alchemy.com/v2/%s")
    (:linea . "https://linea-mainnet.g.alchemy.com/v2/%s")
    (:fantom . "https://fantom-mainnet.g.alchemy.com/v2/%s")
    (:polynomial . "https://polynomial-mainnet.g.alchemy.com/v2/%s")))

(defun foundry-alchemy-network-url-for-api-key (network api-key)
  "Return the Alchemy URL for NETWORK with API-KEY."
  (let ((template (alist-get network foundry-alchemy-network-url-templates)))
    (format template api-key)))

;; get api key from environment
;; can be either WEB3_ALCHEMY_PROJECT_ID or WEB3_ALCHEMY_API_KEY
(defun foundry-alchemy-api-key ()
  "Get the Alchemy API key from the environment."
  (or (getenv "WEB3_ALCHEMY_PROJECT_ID")
      (getenv "WEB3_ALCHEMY_API_KEY")))

(defun foundry-alchemy-network-url (network)
  "Return the Alchemy URL for NETWORK."
  (foundry-alchemy-network-url-for-api-key network (foundry-alchemy-api-key)))

(provide 'foundry-alchemy)
;;; foundry-alchemy.el ends here
