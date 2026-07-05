-- Set Terminal cursor options
-- vim.opt.guicursor:append(",t:hor20-blinkon500-blinkoff500-TermCursor")

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true }),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end,
})

-- Automatically go to insert mode when entering a terminal buffer
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert!")
  end,
})

if (vim.fn.has("nvim-0.10") == 1) then
  -- Listen for OSC 7 Directory Changes from the Shell
  --   Requires neovim >= 0.10 for TermRequest autocommand
  vim.api.nvim_create_autocmd({ "TermRequest" }, {
    desc = "Handles OSC 7 cross-platform directory changes",
    callback = function(ev)
      -- Ensure the request is an OSC 7 path sequence
      if string.sub(vim.v.termrequest, 1, 4) == "\27]7;" then
        -- Extract path, stripping out the file:// protocol prefix
        -- local _, _, path = string.find(vim.v.termrequest, "file://[^/]+(.*)\27\\")
        local _, _, path = string.find(vim.v.termrequest, "file://[^/]+(.*)")
        -- local path = vim.v.termrequest
        if path then
          -- Handle Windows URI decoding if backslashes or encoded chars exist
          path = path:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end)
          -- Save it explicitly to this terminal buffer
          vim.api.nvim_buf_set_var(ev.buf, "terminal_cwd", path)
          -- Force a statusline redraw
          vim.cmd("redrawstatus")
        end
      end
    end,
  })
end
