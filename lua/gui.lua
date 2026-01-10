if vim.g.windows then
  vim.o.guifont = "CaskaydiaMono Nerd Font Mono,Cascadia Code,Consolas:h10"
elseif vim.g.macos then
  vim.o.guifont = "CaskaydiaMono Nerd Font Mono,SF Mono,Menlo:h10"
else
  vim.o.guifont = "CaskaydiaMono Nerd Font Mono,DejaVu Sans Mono:h10"
end

if vim.g.neovide then
  -- Neovide GUI configurations
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0
end
