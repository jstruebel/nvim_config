-- List of file/directory patterns that indicate the parent directory
-- is a project root
local root_patterns = { ".git", ".nvim", ".vscode" }

local function change_workdir(opts)
  local start_dir = vim.fn.expand('%:p')

  if not (vim.fn.isdirectory(start_dir) == 1) then
    start_dir = vim.fn.expand('%:p:h')
  end

  local root = vim.fs.dirname(vim.fs.find(root_patterns, {
    path = start_dir, upward = true })[1]) or start_dir
  local cd_cmd = (opts and opts.cmd or 'cd') .. ' '

  if root and vim.fn.getcwd(-1,-1) ~= root then
    vim.cmd(cd_cmd .. root)
    if string.match(cd_cmd, "^cd") then
      print("Changed global working directory to " .. root)
    end
  end

end

local workdir_augrp = vim.api.nvim_create_augroup("WorkDir", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  group = workdir_augrp,
  callback = function(args)
    change_workdir({cmd = 'cd'})
  end,
  desc = "Set global working directory",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  group = workdir_augrp,
  callback = function(args)
    if vim.api.nvim_buf_get_option(args.buf, 'buftype') == '' then
      change_workdir({cmd = 'lcd'})
    end
  end,
  desc = "Set local buffer working directory when buffer is a file",
})

vim.keymap.set("n", "<leader>dg", change_workdir, {noremap=true, silent=true, desc="Change global workdir to current buffer root"})
