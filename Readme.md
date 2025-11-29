# ⚡ Steix.nvim

A modern, highly optimized Neovim configuration focused on speed, excellent developer experience, and robust tooling for web development (especially PHP/Laravel).

## Dashboard

!["Steix Dashboard"]("steix.png")

## ✨ Features

- **Fast & Reliable:** Powered by `lazy.nvim` for blazing-fast startup times and efficient plugin loading.
- **Aesthetic UI:** Stunning UI with **catppuccin** colors, **bufferline.nvim**, and a powerful **lualine.nvim** status line.
- **Intelligent Completion:** Advanced completion using **nvim-cmp** integrated with LSP, snippets, paths, and buffers.
- **Command Pallet & Diagnostics:** Uses **snacks.nvim** for an integrated command pallet and enhanced diagnostics display.
- **Web Dev Focus:** Dedicated tooling for PHP, Laravel (`larago.nvim`, `laravel.nvim`), and general web development.
- **Enhanced Navigation:** Smart file tree (**nvim-tree.lua**) and project management (**project.nvim**).

---

## 🚀 Installation

This configuration assumes you have a recent version of **Neovim (0.9.0+)** installed and configured.

### Prerequisites

- Git
- **Neovim (v0.9.0 or later)**
- A **Nerd Font** for proper icon display (Recommended)

### Steps

1.  **Backup (Optional):** If you have an existing Neovim configuration, back it up:

    ```bash
    mv ~/.config/nvim{,.bak}
    ```

2.  **Clone the Repository:** Clone this repository into your Neovim configuration directory.

    ```bash
    git clone [https://github.com/Eysteix/steix.nvim.git](https://github.com/Eysteix/steix.nvim.git) ~/.config/nvim
    ```

3.  **Launch Neovim:**

    ```bash
    nvim
    ```

4.  **Initial Setup:** On the first launch, `lazy.nvim` will automatically install all necessary plugins. If prompted, run `:Lazy install` or `:checkhealth`.

---

## ⚙️ Key Bindings

This configuration uses **which-key.nvim** to provide an interactive cheat sheet. Press `<leader>` (**Space** by default) to see available mappings.

| Keymap (Normal Mode) | Description                                                        |
| :------------------- | :----------------------------------------------------------------- |
| **`<leader>e`**      | **Toggle the `nvim-tree.lua` file explorer (Primary Navigation).** |
| `<leader>lg`         | Open the Lazygit TUI utility in a floating window.                 |
| `<leader>w`          | Save the current buffer.                                           |
| `<leader>q`          | Close the current window.                                          |
| `<leader>f`          | Open the `snacks.nvim` fuzzy finder/command pallet.                |
| `[d` / `]d`          | Jump between diagnostics (errors/warnings).                        |
| `gl`                 | Show diagnostics hover window on the current line.                 |

---

## 📦 Plugin List

`steix.nvim` is built on top of a curated list of powerful plugins, all managed by **lazy.nvim**.

### Core

| Plugin Name      | Description                                            |
| :--------------- | :----------------------------------------------------- |
| `lazy.nvim`      | The next-generation Neovim plugin manager.             |
| `plenary.nvim`   | A vital utility library for many plugins.              |
| `which-key.nvim` | Display a pop-up with available key bindings.          |
| `lualine.nvim`   | A fast and highly configurable status line.            |
| `catppuccin`     | The beautiful color scheme used throughout the config. |

### LSP & Completion

| Plugin Name                            | Description                                                            |
| :------------------------------------- | :--------------------------------------------------------------------- |
| `nvim-lspconfig`                       | Quickstart configurations for 100+ LSP servers.                        |
| `mason.nvim` / `mason-lspconfig.nvim`  | Easily manage and install LSP servers, linters, and formatters.        |
| `none-ls.nvim` / `none-ls-extras.nvim` | Use formatters and linters (like Prettier, ESLint) without a full LSP. |
| `nvim-cmp` & Integrations              | Context-aware autocompletion framework.                                |
| `LuaSnip` / `friendly-snippets`        | Fast and flexible snippet engine and collection.                       |
| `nvim-lightbulb`                       | Show a lightbulb icon when code actions are available.                 |

### Development Utilities

| Plugin Name                | Description                                                |
| :------------------------- | :--------------------------------------------------------- |
| `nvim-treesitter`          | Faster, more accurate highlighting and structural editing. |
| `nvim-tree.lua`            | A modern, fast file explorer.                              |
| `nvim-dap` / `nvim-dap-ui` | Debug Adapter Protocol (DAP) integration and UI.           |
| `rest.nvim`                | Run HTTP requests directly within Neovim.                  |
| `Comment.nvim`             | Effortless commenting/uncommenting with `gc` and `gb`.     |
| `nvim-surround`            | Manipulate surroundings like quotes/parentheses.           |
| `auto-save.nvim`           | Automatically saves your buffer.                           |
| `project.nvim`             | Project management and session handling.                   |
| `lazygit.nvim`             | Seamlessly launch the Lazygit TUI within Neovim.           |

### UI & Aesthetics

| Plugin Name                                         | Description                                           |
| :-------------------------------------------------- | :---------------------------------------------------- |
| `bufferline.nvim`                                   | Beautiful tab/buffer line at the top.                 |
| `indent-blankline.nvim` / `indent-rainbowline.nvim` | Shows indentation lines for visual clarity.           |
| `mini.icons`                                        | Minimal and elegant icons for files and buffers.      |
| **`snacks.nvim`**                                   | **Enhanced diagnostics and command pallet features.** |
| `edgy.nvim`                                         | Highly configurable window arrangement manager.       |

### PHP / Laravel Specific

| Plugin Name                    | Description                                                |
| :----------------------------- | :--------------------------------------------------------- |
| `larago.nvim` / `laravel.nvim` | Utilities, commands, and snippets for Laravel development. |
| `phptools.nvim`                | Enhanced PHP tooling and features.                         |

---

## 🤝 Contributing

Contributions are welcome! If you find a bug or have a suggestion, please open an issue or submit a pull request on the [Eysteix/steix.nvim](https://github.com/Eysteix/steix.nvim) repository.

## 📄 License

This configuration is released under the **MIT License**. See the `LICENSE` file for more details.

---
