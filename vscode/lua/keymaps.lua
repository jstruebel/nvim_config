-- VSCode specific maps
vim.g.mapleader = " " -- use space
vim.g.maplocalleader = " " -- use space

-- Commenting
-- Map commenting toggles to match numToStr/Comment.nvim
local vscode = require("vscode")
local function esc()
    local key = vim.api.nvim_replace_termcodes("<esc>", true, true, true)
    vim.api.nvim_feedkeys(key, "n", false)
end
local comment_block = vscode.to_op(function (ctx)
   local cmd = "editor.action.blockComment"
   local opts = { range = ctx.range, callback = esc }
   vscode.action(cmd, opts)
end)
local comment_line = vscode.to_op(function (ctx)
   local cmd = "editor.action.commentLine"
   local opts = { range = ctx.range, callback = esc }
   if ctx.is_linewise and ctx.is_current_line then
    opts.range = nil
   end
   vscode.action(cmd, opts)
end)
local comment_line_line = function ()
    return comment_line() .. "_"
end
local comment_block_line = function ()
    return comment_block() .. "_"
end
vim.keymap.set({"x", "n", "o" }, "gc", comment_line, { expr = true })
vim.keymap.set("n", "gcc", comment_line_line, { expr = true })
vim.keymap.set({"x", "n", "o" }, "gb", comment_block, { expr = true })
vim.keymap.set("n", "gbc", comment_block_line, { expr = true })

-- Code Navigation
vim.keymap.set("n", "gr", "<cmd>call VSCodeNotify('editor.action.goToReferences')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "gd", "<cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "gy", "<cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "gi", "<cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>", {noremap=true, silent=true})

-- Refactoring
vim.keymap.set("n", "<leader>r", "<cmd>call VSCodeNotify('editor.action.rename')<CR>", {noremap=true, silent=true})

-- Move between windows/splits
vim.keymap.set("n", "<C-h>", "<cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<C-j>", "<cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<C-k>", "<cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<C-l>", "<cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>", {noremap=true, silent=true})

-- Move lines in visual mode
vim.keymap.set("x", "J", ":m '>+1<CR>gv", {noremap=true, silent=true})
vim.keymap.set("x", "K", ":m '<-2<CR>gv", {noremap=true, silent=true})

-- Toggle folding
vim.keymap.set("n", "za", "<cmd>call VSCodeNotify('editor.toggleFold')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "zR", "<cmd>call VSCodeNotify('editor.unfoldAll')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "zM", "<cmd>call VSCodeNotify('editor.foldAll')<CR>", {noremap=true, silent=true})

-- Clear search highlights
vim.keymap.set("n", "<leader>c", ":nohl<CR>", {noremap=true, silent=true})

-- Toggle panes/open explorer & find panes
vim.keymap.set("n", "<leader>s", "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>", {silent=true})
vim.keymap.set("n", "<leader>m", "<cmd>call VSCodeNotify('editor.action.toggleMinimap')<CR>", {silent=true})
vim.keymap.set("n", "<leader>t", "<cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>", {silent=true})
vim.keymap.set("n", "<leader>e", "<cmd>call VSCodeNotify('workbench.view.explorer')<CR>", {silent=true})
vim.keymap.set("n", "<leader>ff", "<cmd>Ex<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>fg", "<cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>", {noremap=true, silent=true})