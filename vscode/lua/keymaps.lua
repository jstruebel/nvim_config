-- VSCode specific maps
local map = vim.keymap.set

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
map({"x", "n", "o" }, "gc", comment_line, { expr = true, desc = "Comment with line style" })
map("n", "gcc", comment_line_line, { expr = true, desc = "Comment with line style" })
map({"x", "n", "o" }, "gb", comment_block, { expr = true, desc = "Comment with block style" })
map("n", "gbc", comment_block_line, { expr = true, desc = "Comment with block style" })

-- Code Navigation
map("n", "gr", "<cmd>call VSCodeNotify('editor.action.goToReferences')<CR>", {noremap=true, silent=true, desc="Goto Reference"})
map("n", "gd", "<cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>", {noremap=true, silent=true, desc="Goto Definition"})
map("n", "gy", "<cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>", {noremap=true, silent=true, desc="Goto Type Definition"})
map("n", "gi", "<cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>", {noremap=true, silent=true, desc="Goto Implementation"})

-- Refactoring
map("n", "<leader>r", "<cmd>call VSCodeNotify('editor.action.rename')<CR>", {noremap=true, silent=true, desc="Rename"})

-- Move between windows/splits
map("n", "<C-h>", "<cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>", {noremap=true, silent=true,desc="Move to window on left of current"})
map("n", "<C-j>", "<cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>", {noremap=true, silent=true,desc="Move to window below current"})
map("n", "<C-k>", "<cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>", {noremap=true, silent=true,desc="Move to window above current"})
map("n", "<C-l>", "<cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>", {noremap=true, silent=true,desc="Move to window on right of current"})

-- Manage Window Splits
map("n", "<leader>wv", "<cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>", {silent=true,desc="Open new window to right (vertical)"})
map("n", "<leader>wh", "<cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>", {silent=true,desc="Open new window below (horizontal)"})
map("n", "<leader>we", "<C-w>=", {silent=true,desc="Make windows equal"})

-- Manage Tabs
map("n", "<leader>tn", "<cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>", {silent=true,desc="Open new tab"})

-- Move lines in visual mode
map("x", "J", ":m '>+1<CR>gv", {noremap=true, silent=true,desc="Move line up one (visual mode)"})
map("x", "K", ":m '<-2<CR>gv", {noremap=true, silent=true,desc="Move line down one (visual mode)"})

-- Toggle folding
map("n", "za", "<cmd>call VSCodeNotify('editor.toggleFold')<CR>", {noremap=true, silent=true, desc="Toggle current fold"})
map("n", "zR", "<cmd>call VSCodeNotify('editor.unfoldAll')<CR>", {noremap=true, silent=true, desc="Open all folds"})
map("n", "zM", "<cmd>call VSCodeNotify('editor.foldAll')<CR>", {noremap=true, silent=true, desc="Close all folds"})

-- Toggle panes/open explorer & find panes
map("n", "<leader>s", "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>", {silent=true,desc="Toggle sidebar"})
map("n", "<leader>m", "<cmd>call VSCodeNotify('editor.action.toggleMinimap')<CR>", {silent=true,desc="Toggle minimap"})
map("n", "<leader>o", "<cmd>call VSCodeNotify('workbench.action.output.toggleOutput')<CR>", {silent=true,desc="Toggle output panel"})
map("n", "<leader>p", "<cmd>call VSCodeNotify('workbench.action.togglePanel')<CR>", {silent=true,desc="Toggle panel"})
map("n", "<leader>t", "<cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>", {silent=true,desc="Toggle terminal panel"})
map("n", "<leader>d", "<cmd>call VSCodeNotify('editor.action.showHover')<CR>", {silent=true,desc="Show hover tooltip"})
map("n", "<leader>a", "<cmd>call VSCodeNotify('editor.action.quickFix')<CR>", {silent=true,desc="Open quickfix"})
map("n", "<leader>g", "<cmd>call VSCodeNotify('workbench.view.scm')<CR>", {silent=true,desc="View SCM"})
map("n", "<leader>bp", "<cmd>call VSCodeNotify('editor.debug.action.toggleBreakpoint')<CR>", {silent=true,desc="Toggle breakpoint"})
map("n", "<leader>sp", "<cmd>call VSCodeNotify('workbench.actions.view.problems')<CR>", {silent=true,desc="Show problems"})
map("n", "<leader>cn", "<cmd>call VSCodeNotify('notifications.clearAll')<CR>", {silent=true,desc="Clear notifications"})
map("n", "<leader>e", "<cmd>call VSCodeNotify('workbench.view.explorer')<CR>", {silent=true,desc="Open explorer sidebar"})
map("n", "<leader>ff", "<cmd>Ex<CR>", {noremap=true, silent=true,desc="Find File"})
map("n", "<leader>fg", "<cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>", {noremap=true, silent=true, desc="Find in all files"})

-- Perforce Extension
map("n", "<leader>pc", "<cmd>call VSCodeNotify('perforce.menuFunctions')<CR>", {noremap=true, silent=true, desc="Perforce commands"})
map("n", "<leader>pa", "<cmd>call VSCodeNotify('perforce.add')<CR>", {noremap=true, silent=true, desc="Perforce add file"})
map("n", "<leader>pe", "<cmd>call VSCodeNotify('perforce.edit')<CR>", {noremap=true, silent=true, desc="Perforce open for edit"})
map("n", "<leader>pd", "<cmd>call VSCodeNotify('perforce.diff')<CR>", {noremap=true, silent=true, desc="Perforce show diffs"})
map("n", "<leader>pm", "<cmd>call VSCodeNotify('perforce.move')<CR>", {noremap=true, silent=true, desc="Perforce move file"})
map("n", "<leader>pr", "<cmd>call VSCodeNotify('perforce.revert')<CR>", {noremap=true, silent=true, desc="Perforce revert changes"})
map("n", "<leader>ps", "<cmd>call VSCodeNotify('perforce.sync')<CR>", {noremap=true, silent=true, desc="Perforce sync to server"})
