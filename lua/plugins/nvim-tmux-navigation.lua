-- Conditionally load only if not in VSCode
if not vim.g.vscode then
  vim.cmd("packadd! nvim-tmux-navigation")

  -- Initialize plugin
  local nvim_tmux_nav = require('nvim-tmux-navigation')
  nvim_tmux_nav.setup({
    disable_when_zoomed = false
  })
  
  -- Setup Keymaps to use this module
  local map = vim.keymap.set
  map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, {noremap=true, silent=true,desc="Move to window on left of current"})
  map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, {noremap=true, silent=true,desc="Move to window below current"})
  map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, {noremap=true, silent=true,desc="Move to window above current"})
  map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, {noremap=true, silent=true,desc="Move to window on right of current"})
  map("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, {noremap=true, silent=true,desc="Move to previously active window"})

  -- Set tmux variable when nvim is active using autocommands
  if vim.env.TMUX then
    local function tmux_command(command)
      local tmux_socket = vim.fn.split(vim.env.TMUX, ",")[1]
      return vim.fn.system("tmux -S " .. tmux_socket .. " " .. command)
    end

    local nvim_tmux_nav_group = vim.api.nvim_create_augroup("NvimTmuxNavigation", {})

    vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
      group = nvim_tmux_nav_group,
      callback = function()
        tmux_command("set-option -p @is_vim yes")
      end,
    })

    vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
      group = nvim_tmux_nav_group,
      callback = function()
        tmux_command("set-option -p -u @is_vim")
      end,
    })
  end

end
