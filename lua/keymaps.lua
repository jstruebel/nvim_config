-- New Key maps

-- Yank to end of line
vim.keymap.set("n", "Y", "yg$", {})

-- Keep selection when indenting/outdenting
vim.keymap.set("v", "<", "<gv", {noremap=true, silent=true})
vim.keymap.set("v", ">", ">gv", {noremap=true, silent=true})
vim.keymap.set("x", "<", "<gv", {noremap=true, silent=true})
vim.keymap.set("x", ">", ">gv", {noremap=true, silent=true})

-- Clear search highlights
vim.keymap.set("n", "<leader>c", ":nohl<CR>", {noremap=true, silent=true})

-- Dump helpful information to a new buffer
-- Reference: https://tech.serhatteker.com/post/2022-07/dump-command-output-to-buffer-in-neovim/
vim.keymap.set("n", "<leader>?d", "<cmd>new|pu=execute('digraphs')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>?k", "<cmd>new|pu=execute('map')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>?kn", "<cmd>new|pu=execute('nmap')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>?ki", "<cmd>new|pu=execute('imap')<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>?kv", "<cmd>new|pu=execute('vmap')<CR>", {noremap=true, silent=true})

if not vim.g.vscode then
    -- Move between windows/splits
    vim.keymap.set("n", "<C-h>", "<C-w>h", {noremap=true, silent=true})
    vim.keymap.set("n", "<C-j>", "<C-w>j", {noremap=true, silent=true})
    vim.keymap.set("n", "<C-k>", "<C-w>k", {noremap=true, silent=true})
    vim.keymap.set("n", "<C-l>", "<C-w>l", {noremap=true, silent=true})

    -- Move between windows/splits from terminal
    vim.keymap.set("t", "<C-h>", "<cmd>wincmd h", {silent=true})
    vim.keymap.set("t", "<C-j>", "<cmd>wincmd j", {silent=true})
    vim.keymap.set("t", "<C-k>", "<cmd>wincmd k", {silent=true})
    vim.keymap.set("t", "<C-l>", "<cmd>wincmd l", {silent=true})

    -- Resize windows using arrow keys
    vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", {noremap=true, silent=true})
    vim.keymap.set("n", "<C-down>", ":resize +2<CR>", {noremap=true, silent=true})
    vim.keymap.set("n", "<C-right>", ":vertical resize -2<CR>", {noremap=true, silent=true})
    vim.keymap.set("n", "<C-left>", ":vertical resize +2<CR>", {noremap=true, silent=true})

    -- Manage Window Splits
    vim.keymap.set("n", "<leader>sv", "<C-w>v", {silent=true})
    vim.keymap.set("n", "<leader>sh", "<C-w>s", {silent=true})
    vim.keymap.set("n", "<leader>se", "<C-w>=", {silent=true})
    
    -- Manage Tabs
    vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {silent=true})
    vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {silent=true})
    vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", {silent=true})

    -- Navigate Buffers
    vim.keymap.set("n", "<leader>b", "<cmd>buffers<CR>", {silent=true})
    vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", {silent=true})
    vim.keymap.set("n", "]b", "<cmd>bnext<CR>", {silent=true})
    
    --Exit insert mode in terminal (default is confusing)
    vim.keymap.set("t", "<C-[>", "<C-\\><C-N>", {noremap=true, silent=true})

    -- Move lines in visual mode
    vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", {noremap=true, silent=true})
    vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", {noremap=true, silent=true})

    -- Reload configuration
    local function reload()
      dofile(vim.env.MYVIMRC)
      print("Configuration reloaded")
    end

    vim.keymap.set("n", "<leader>ve", ":tabnew $MYVIMRC<CR>", {noremap=true, silent=true})
    vim.keymap.set("n", "<leader>vs", reload, {noremap=true, silent=true})
end
