# Foundry Anvil Transient for Emacs

This package provides an Emacs interface for launching and configuring Anvil, the local testnet node from the Foundry suite of Ethereum development tools.

## Features

- Easy-to-use transient interface for configuring Anvil options
- Customizable fork URL options
- Launches Anvil in a dedicated buffer with proper output handling

## Installation

1. Ensure you have Foundry installed on your system. If not, follow the [official Foundry installation guide](https://book.getfoundry.sh/getting-started/installation).

2. Add the `foundry.el` file to your Emacs load path.

3. Add the following to your Emacs configuration:

   ```elisp
   (require 'foundry)
   ```

## Usage

1. Run `M-x foundry-anvil-launch` to open the Anvil configuration transient.

2. Use the transient interface to set your desired Anvil options.

3. Press `l` to launch Anvil with the selected options.

## Configuring Fork URLs

You can customize the preconfigured fork URL options available in the transient. There are two ways to do this:

### Using the Customize Interface

1. Run `M-x customize-group RET foundry RET`
2. Find the `Foundry Anvil Network Fork Url Options` setting
3. Add, modify, or remove entries as needed
4. Save your changes

### Using Elisp in Your Config File

Add the following to your Emacs configuration file (e.g., `init.el` or `.emacs`):

```elisp
(setq foundry-anvil-network-fork-url-options
      '(("local" . nil)
        ("mainnet" . "https://eth-mainnet.g.alchemy.com/v2/<YOUR_API_KEY>")
        ("base" . "https://base-mainnet.g.alchemy.com/v2/<YOUR_API_KEY")))
```

Replace `<YOUR_API_KEY>` with your actual API key for the respective networks.

### Ad-Hoc Forking
You can also simply provide a url when presented with the list of fork options. This url will be used to launch the anvil node in fork mode.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the GPL-3.0 License - see the LICENSE file for details.
