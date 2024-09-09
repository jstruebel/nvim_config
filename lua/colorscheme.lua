-- Select colorscheme based on termguicolors
--   This isn't working for terminals that aren't
--   24-bit color since nvim defaults termguicolors
--   to true while parsing the config files even when
--   it's not supported and is set to false once loaded
if vim.o.termguicolors then
    vim.cmd("colorscheme gruvbox-flat")
else
    vim.cmd("colorscheme retrobox")
end