-- Conditionally load only if not in VSCode
if not vim.g.vscode then
  vim.cmd("packadd! gruvbox-material")

end
