-- New Key maps
local map = vim.keymap.set

-- Yank to end of line
map("n", "Y", "yg$", {desc="Yenk text from cursor to end of line"})

-- Keep selection when indenting/outdenting
map("v", "<", "<gv", {noremap=true, silent=true, desc="Shift indenting one level left"})
map("v", ">", ">gv", {noremap=true, silent=true, desc="Shift indenting one level right"})
map("x", "<", "<gv", {noremap=true, silent=true, desc="Shift indenting one level left"})
map("x", ">", ">gv", {noremap=true, silent=true, desc="Shift indenting one level right"})

-- Search
map("n", "n", "nzzzv", {noremap=true, silent=true, desc="Goto next result"})
map("n", "N", "Nzzzv", {noremap=true, silent=true, desc="Goto previous result"})
map("n", "<leader>c", ":nohl<CR>", {noremap=true, silent=true, desc="Clear search highlighting"})

-- Replace
map("n", "<leader>rl", ":s/\\v", {noremap=true, silent=true, desc="Replace in current line"})
map("n", "<leader>rf", ":%s/\\v", {noremap=true, silent=true, desc="Replace in current file"})
map("n", "<leader>rv", ":%s/\\%V", {noremap=true, silent=true, desc="Replace in current visual selection"})

-- Selections
map("n", "L", "vg_", {noremap=true, silent=true, desc="Select text from cursor to end of line"})
map("n", "<leader>sa", "ggVG", {noremap=true, silent=true, desc="Select all text"})

-- Dump helpful information to a new buffer
-- Reference: https://tech.serhatteker.com/post/2022-07/dump-command-output-to-buffer-in-neovim/
map("n", "<leader>?d", "<cmd>new|pu=execute('digraphs')<CR>", {noremap=true, silent=true, desc="Dump all digraphs to new buffer"})
map("n", "<leader>?k", "<cmd>new|pu=execute('map')<CR>", {noremap=true, silent=true, desc="Dump all keymaps to new buffer"})
map("n", "<leader>?kn", "<cmd>new|pu=execute('nmap')<CR>", {noremap=true, silent=true,desc="Dump normal keymaps to new buffer"})
map("n", "<leader>?ki", "<cmd>new|pu=execute('imap')<CR>", {noremap=true, silent=true,desc="Dump insert keymaps to new buffer"})
map("n", "<leader>?kv", "<cmd>new|pu=execute('vmap')<CR>", {noremap=true, silent=true,desc="Dump visual keymaps to new buffer"})

if not vim.g.vscode then
  -- Move between windows/splits
  map("n", "<C-h>", "<C-w>h", {noremap=true, silent=true,desc="Move to window on left of current"})
  map("n", "<C-j>", "<C-w>j", {noremap=true, silent=true,desc="Move to window below current"})
  map("n", "<C-k>", "<C-w>k", {noremap=true, silent=true,desc="Move to window above current"})
  map("n", "<C-l>", "<C-w>l", {noremap=true, silent=true,desc="Move to window on right of current"})
  map("n", "<C-\\>", "<C-w>p", {noremap=true, silent=true,desc="Move to previously active window"})

  -- Move between windows/splits from terminal
  map("t", "<C-h>", "<cmd>wincmd h<cr>", {silent=true,desc="Move to window on left of current"})
  map("t", "<C-j>", "<cmd>wincmd j<cr>", {silent=true,desc="Move to window below current"})
  map("t", "<C-k>", "<cmd>wincmd k<cr>", {silent=true,desc="Move to window above current"})
  map("t", "<C-l>", "<cmd>wincmd l<cr>", {silent=true,desc="Move to window on right of current"})

  -- Resize windows using arrow keys
  map("n", "<C-Up>", ":resize -2<CR>", {noremap=true, silent=true,desc="Resize window up"})
  map("n", "<C-down>", ":resize +2<CR>", {noremap=true, silent=true,desc="Resize window down"})
  map("n", "<C-right>", ":vertical resize -2<CR>", {noremap=true, silent=true,desc="Resize window to right"})
  map("n", "<C-left>", ":vertical resize +2<CR>", {noremap=true, silent=true,desc="Resize window to left"})

  -- Manage Window Splits
  map("n", "<leader>wv", "<cmd>vnew<CR>", {silent=true,desc="Open new window to right (vertical)"})
  map("n", "<leader>wh", "<cmd>new<CR>", {silent=true,desc="Open new window below (horizontal)"})
  map("n", "<leader>we", "<C-w>=", {silent=true,desc="Make windows equal"})
  map("n", "<leader>wr", "<C-w>r", {silent=true,desc="Move window to the right/down"})
  map("n", "<leader>wR", "<C-w>R", {silent=true,desc="Move window to the left/up"})
  map("n", "<leader>wH", "<C-w>H", {silent=true,desc="Move window to the left, full height"})
  map("n", "<leader>wJ", "<C-w>J", {silent=true,desc="Move window to the bottom, full width"})
  map("n", "<leader>wK", "<C-w>K", {silent=true,desc="Move window to the top, full width"})
  map("n", "<leader>wL", "<C-w>L", {silent=true,desc="Move window to the right, full height"})
  map("n", "<leader>wtv", "<cmd>vert te<CR>", {silent=true,desc="Open new terminal window to right (vertical)"})
  map("n", "<leader>wth", "<cmd>hor te<CR>", {silent=true,desc="Open new terminal window below (horizontal)"})
  map("n", "<leader>wfv", "<C-w>v", {silent=true,desc="Open new window to right with current file (vertical)"})
  map("n", "<leader>wfh", "<C-w>s", {silent=true,desc="Open new window below with current file (horizontal)"})
  
  -- Manage Tabs
  map("n", "<leader>tn", "<cmd>tabnew<CR>", {silent=true,desc="Open new tab"})
  map("n", "<leader>tf", "<cmd>tabnew %<CR>", {silent=true,desc="Open new tab with current file"})
  map("n", "<leader>tc", "<cmd>tabclose<CR>", {silent=true,desc="Close current tab"})
  map("n", "<leader>to", "<cmd>tabonly<CR>", {silent=true,desc="Close all other tabs"})
  map("n", "<leader>tt", "<cmd>tabnew <bar> te <CR>", {silent=true,desc="Open new tab with terminal"})

  -- Manage Buffers
  map("n", "<leader>bl", "<cmd>buffers<CR>", {silent=true,desc="List all open buffers"})
  map("n", "<leader>bp", "<cmd>bprevious<CR>", {silent=true,desc="Load previous buffer in current window"})
  map("n", "<leader>bn", "<cmd>bnext<CR>", {silent=true,desc="Load next buffer in current window"})
  map("n", "<leader>bd", "<cmd>bp|bd #<CR>", {silent=true,desc="Close current buffer without closing window"})
  map("n", "<leader>bt", "<cmd>term<CR>", {silent=true,desc="Open new terminal in current window"})
  map("n", "<leader>bb", "<cmd>enew<CR>", {silent=true,desc="Open new buffer in current window"})
  
  --Exit insert mode in terminal (default is confusing)
  map("t", "<C-[>", "<C-\\><C-N>", {noremap=true, silent=true,desc="Exit insert mode (terminal)"})

  -- Move lines in visual mode
  map("x", "J", ":m '>+1<CR>gv=gv", {noremap=true, silent=true,desc="Move line up one (visual mode)"})
  map("x", "K", ":m '<-2<CR>gv=gv", {noremap=true, silent=true,desc="Move line down one (visual mode)"})

  -- Reload configuration
  local function reload()
    dofile(vim.env.MYVIMRC)
    print("Configuration reloaded")
  end

  map("n", "<leader>ve", ":tabnew $MYVIMRC<CR>", {noremap=true, silent=true,desc="Open neovim config in new tab"})
  map("n", "<leader>vs", reload, {noremap=true, silent=true,desc="Reload neovim config"})
end
