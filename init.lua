-- This is the main configuration file for Neovim
-- It loads various modules to set up plugins, keymaps, and options
require("config.lazy")

-- This module configures Language Server Protocol (LSP) settings
require("config.lsp_s")
-- This module contains custom setups for various plugins and tools

require("lua.config.package-setups")

require("config.m-term")

-- This module configures SASS-related settings and tools
require("config.sass")

-- This module sets up key mappings for Neovim
require("config.keymaps")

require("config.options")
