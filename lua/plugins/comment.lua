return {
   'numToStr/Comment.nvim', 
   enabled = not vim.g.vscode,
   config = function ()
        require("Comment").setup()
   end,
}