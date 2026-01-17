-- Neovim configuration
--   Only common and terminal specific configuration sourced from
--   this file. VS Code mode configuration should be placed in
--   nvim/vscode directory which is sourced automatically by
--   vscode-neovim extension

-- set leader here before any configurations loaded
vim.g.mapleader = " " -- use space
vim.g.maplocalleader = " " -- use space


if not vim.g.vscode then
  -- set variables to control configuration
  vim.g.windows = (vim.fn.has("win32") or vim.fn.has("win64")) == 1
  vim.g.macos = vim.fn.has("mac") == 1
  vim.g.is_usb = os.getenv("NEOVIM_USB")
  vim.g.is_ide = os.getenv("NEOVIM_IDE")
  if vim.g.windows then
    vim.g.pathsep = "\\"
  else
    vim.g.pathsep = "/"
  end
end

require "options"
require "keymaps"
require "plugins"

if not vim.g.vscode then
  -- Standalone configurations
  require "gui"
  require "colorscheme"
  require "statusline"
  require "workdir"
  if vim.g.is_ide then
    -- Add IDE Plugin Configuration
    --sessions
    --completion
    --lsp
    --indent-blankline
    --gitsigns/vcs signs (signify)
    --snippets
    --autopairs
    --terminal (toggleterm/terminal.nvim)
    --telescope/fuzzy-find?
    --treesitter?
    --whichkey?
  end
end
