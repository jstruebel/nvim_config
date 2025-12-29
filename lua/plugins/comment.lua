-- Conditionally load only if not in VSCode
if not vim.g.vscode then
  vim.cmd("packadd! Comment.nvim")

  -- Initialize plugin
  require('Comment').setup({
    ignore = '^$',
  })
end
