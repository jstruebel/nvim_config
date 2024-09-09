-- Neovim options configuration

local opt = vim.opt

-- tabs & indentation
opt.tabstop = 2                                         -- 2 spaces  for tabs
opt.softtabstop = 2                                     -- 2 spaces for soft tabs
opt.shiftwidth = 2                                      -- 2 spaces for indent width
opt.expandtab = true                                    -- expand tabs to spaces
opt.autoindent = true                                   -- copy indent from current line when starting a new line

-- search settings
opt.ignorecase = true                                   -- ignore case when searching
opt.smartcase = true                                    -- if you include mixed case in search use case sensitive search
opt.hlsearch = true                                     -- highlight search items
opt.incsearch = true                                    -- search incrementally as you enter search expression

-- cursor line
opt.cursorline = true                                   -- highlight the current cursor line

-- backspace
opt.backspace = "indent,eol,start"                      -- allow backspace on indent, end of line or insert start

-- clipboard
opt.clipboard:append("unnamedplus")                     -- use system clipboard as the default register

if not vim.g.vscode then
    -- line numbers
    opt.relativenumber = false                          -- show relative line numbers
    opt.number = true                                   -- show line numbers (absolute line number if relativenumber is true)
    opt.colorcolumn = { 120 }                           -- highlight out to column 120

    -- line wrapping
    opt.wrap = true                                         -- enable line wrapping
    opt.breakindent = true                                  -- keep wrapped lines on the same indent level

    -- scrolling offsets
    opt.scrolloff = 8                                   -- provide 8 lines of context when scrolling vertically
    opt.sidescrolloff = 8                               -- provide 8 characters of context when scrolling horizontally

    -- turn on termguicolors if supported
    -- supported terminals include iTerm2, Alacritty, Kitty, Windows Terminal
    -- Should be set by default if terminal with > 256 colors detected
    -- if string.match(os.getenv("TERM"), "-256colors") then
    --     opt.termguicolors = false
    -- else
    --     opt.termguicolors = true
    -- end
    opt.background = "dark"                             -- choose dark background when supported by colorscheme
    opt.signcolumn = "yes"                              -- show sign column so that text doesn't shift
    opt.syntax = "ON"                                   -- enable syntax highlighting

    -- split windows
    opt.splitright = true                                   -- split vertical window to the right
    opt.splitbelow = true                                   -- split horizontal window to the bottom

    -- swapfile, backup & undo
    opt.swapfile = false                                    -- turn off swap file
    opt.backup = false                                      -- turn off backup file
    opt.undodir = vim.fn.stdpath("data") .. "/undo"         -- set location for undo files
    opt.backupdir = vim.fn.stdpath("data") .. "/backup"     -- set location for backup files
    opt.directory = vim.fn.stdpath("data") .. "/swp"        -- set location for swap files
    opt.undofile = true                                     -- enable undo file
end