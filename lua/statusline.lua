local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local function setup_colors()
    return {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_bg_ct = utils.get_highlight("Folded").ctermbg,
        bright_fg = utils.get_highlight("Folded").fg,
        bright_fg_ct = utils.get_highlight("Folded").ctermfg,
        red = utils.get_highlight("DiagnosticError").fg,
        red_ct = utils.get_highlight("DiagnosticError").ctermfg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        dark_red_ct = utils.get_highlight("DiffDelete").ctermbg,
        green = utils.get_highlight("Include").fg,
        green_ct = utils.get_highlight("Include").ctermfg,
        gray = utils.get_highlight("NonText").fg,
        gray_ct = utils.get_highlight("NonText").ctermfg,
        orange = utils.get_highlight("Special").fg,
        orange_ct = utils.get_highlight("Special").ctermfg,
        purple = utils.get_highlight("Constant").fg,
        purple_ct = utils.get_highlight("Constant").ctermfg,
        cyan = utils.get_highlight("Conceal").fg,
        cyan_ct = utils.get_highlight("Conceal").ctermfg,
        filename = utils.get_highlight("Directory").fg,
        filename_ct = utils.get_highlight("Directory").ctermfg,
        special = utils.get_highlight("Function").fg,
        special_ct = utils.get_highlight("Function").ctermfg,
        readonly = utils.get_highlight("Constant").fg,
        readonly_ct = utils.get_highlight("Constant").ctermfg,
        modified = utils.get_highlight("Special").fg,
        modified_ct = utils.get_highlight("Special").ctermfg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_warn_ct = utils.get_highlight("DiagnosticWarn").ctermfg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_error_ct = utils.get_highlight("DiagnosticError").ctermfg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_hint_ct = utils.get_highlight("DiagnosticHint").ctermfg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        diag_info_ct = utils.get_highlight("DiagnosticInfo").ctermfg,
        git_del = utils.get_highlight("DiffDelete").fg,
        git_del_ct = utils.get_highlight("DiffDelete").ctermfg,
        git_add = utils.get_highlight("DiffAdd").fg,
        git_add_ct = utils.get_highlight("DiffAdd").ctermfg,
        git_change = utils.get_highlight("DiffChange").fg,
        git_change_ct = utils.get_highlight("DiffChange").ctermfg,
    }
end

local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,

    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
            n = "N",
            no = "N?",
            nov = "N?",
            noV = "N?",
            ["no\22"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "V",
            vs = "Vs",
            V = "V_",
            Vs = "Vs",
            ["\22"] = "^V",
            ["\22s"] = "^V",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "C",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
        mode_colors = {
            n = { fg = "bright_fg", ctermfg = "bright_fg_ct", bg = "bright_bg", ctermbg = "bright_bg_ct" },
            i = { fg = "green", ctermfg = "green_ct", bg = "gray", ctermbg = "gray_ct" },
            v = { fg = "cyan", ctermfg = "cyan_ct", bg = "gray", ctermbg = "gray_ct" },
            V =  { fg = "cyan", ctermfg = "cyan_ct", bg = "gray", ctermbg = "gray_ct" },
            ["\22"] =  { fg = "cyan", ctermfg = "cyan_ct", bg = "gray", ctermbg = "gray_ct" },
            c =  { fg = "purple", ctermfg = "purple_ct", bg = "gray", ctermbg = "gray_ct" },
            s =  { fg = "cyan", ctermfg = "cyan_ct", bg = "gray", ctermbg = "gray_ct" },
            S =  { fg = "cyan", ctermfg = "cyan_ct", bg = "gray", ctermbg = "gray_ct" },
            ["\19"] =  { fg = "purple", ctermfg = "purple_ct", bg = "gray", ctermbg = "gray_ct" },
            R =  { fg = "orange", ctermfg = "orange_ct", bg = "gray", ctermbg = "gray_ct" },
            r =  { fg = "orange", ctermfg = "orange_ct", bg = "gray", ctermbg = "gray_ct" },
            ["!"] =  { fg = "red", ctermfg = "red_ct", bg = "bright_bg", ctermbg = "bright_bg_ct" },
            t =  { fg = "red", ctermfg = "red_ct", bg = "bright_bg", ctermbg = "bright_bg_ct" },
        }
    },

    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long. Plus a nice Icon.
    provider = function(self)
        return " %2("..self.mode_names[self.mode].."%) "
    end,

    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        -- Use fg to get background color due to reverse in StatusLine highlight
        return { fg = self.mode_colors[mode].fg, bold = true, ctermfg = self.mode_colors[mode].ctermfg, bg = self.mode_colors[mode].bg, ctermbg = self.mode_colors[mode].ctermbg }
    end,

    -- Re-evaluate the component only on ModeChanged event!
    -- Also allows the statusline to be re-evaluated when entering operator-pending mode
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
}

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and its children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

-- We can now define some children separately and add them later
local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    -- Use bg to get foreground color due to reverse in StatusLine highlight
    hl = { bg = "filename", ctermbg = "filename_ct" },
}

local FlexFileName = {
    init = function(self)
        self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
        if self.lfilename == "" then self.lfilename = "[No Name]" end
    end,
    hl = { bg = "filename", ctermbg = "filename_ct" },

    flexible = 2,

    {
        provider = function(self)
            return self.lfilename
        end,
    },
    {
        provider = function(self)
            return vim.fn.pathshorten(self.lfilename)
        end,
    },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        flexible = 3,
        { provider = "[+]", },
        { provider = "+", },
        { provider = "", },
        -- Use bg to get foreground color due to reverse in StatusLine highlight
        hl = { bg = "modified", ctermbg = "modified_ct" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        flexible = 3,
        { provider = "[RO]", },
        { provider = "-R", },
        -- Use bg to get foreground color due to reverse in StatusLine highlight
        hl = { bg = "readonly", ctermbg = "readonly_ct" },
    },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component
local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- Use bg to get foreground color due to reverse in StatusLine highlight
            -- use `force` because we need to override the child's hl foreground
            return { bg = "modified", ctermbg = "modified_ct", bold = true, force=true }
        elseif not vim.bo.modifiable or vim.bo.readonly then
            -- Use bg to get foreground color due to reverse in StatusLine highlight
            -- use `force` because we need to override the child's hl foreground
            return { bg = "readonly", ctermbg = "readonly_ct", bold = true, force=true }
        end
    end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
)

local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    -- Use bg to get foreground color due to reverse in StatusLine highlight
    hl = { bg = utils.get_highlight("Type").fg, ctermbg = utils.get_highlight("Type").ctermfg, bold = true },
}

local FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        -- return enc ~= 'utf-8' and enc:upper()
        return enc:upper()
    end
}

local FileFormat = {
    static = {
        fmt_abbr = { -- change the strings if you like it vvvvverbose!
            unix = "U",
            dos = "D",
            mac = "M",
        }
    },

    provider = function(self)
        local fmt = vim.bo.fileformat
        -- return fmt ~= 'unix' and fmt:upper()
        return self.fmt_abbr[fmt]
    end
}

-- We're getting minimalist here!
local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = "%7(%l/%3L%):%2v",
}

-- Flexible Ruler configuration
local FlexRuler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    flexible = 1,
    {
        provider = "%7(%l/%3L%):%2v",
    },
    {
        provider = "%7(%l/%3L%)",
    },
}

local ScrollBar ={
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
        -- Another variant, because the more choice the better.
        -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
    hl = { fg = "cyan", bg = "bright_bg", ctermfg = "cyan_ct", ctermbg = "bright_bg_ct" },
}

local TerminalName = {
    -- we could add a condition to check that buftype == 'terminal'
    -- or we could do that later (see #conditional-statuslines below)
    provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
        return " " .. tname
    end,
    -- Use bg to get foreground color due to reverse in StatusLine highlight
    hl = { bg = "special", ctermbg = "special_ct", bold = true },
}

local HelpFileName = {
    condition = function()
        return vim.bo.filetype == "help"
    end,
    provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
    end,
    -- Use bg to get foreground color due to reverse in StatusLine highlight
    hl = { bg = "special", ctermbg = "special_ct" },
}

local Align = { provider = "%=" }
local Space = { provider = " " }
local Separator = { provider = "|" }

local FlexFileInfo = {
    flexible = 2,
    {
        FileType, Space, Separator, Space, FileEncoding, Space, Separator, Space, FileFormat, Space, Separator, 
    },
    {
        FileType, Space, Separator, Space, FileEncoding, Space, Separator, 
    },
    {
        FileType, Space, Separator, 
    },
    {
        provider = "",
    },
}

local DefaultStatusline = {
    Space, ViMode, Space, FileNameBlock, Space, Align,
    FlexFileInfo, Space, FlexRuler, Space,
}

local InactiveStatusline = {
    condition = conditions.is_not_active,
    Space, FileType, Space, FileNameBlock, Align,
}

local SpecialStatusline = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive" },
        })
    end,

    Space, FileType, Space, HelpFileName, Align
}

local TerminalStatusline = {

    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    -- Use bg to get foreground color due to reverse in StatusLine highlight
    hl = { bg = "dark_red", ctermbg = "dark_red_ct" },

    -- Quickly add a condition to the ViMode to only show it when buffer is active!
    Space, { condition = conditions.is_active, ViMode, Space }, FileType, Space, TerminalName, Align,
}

local StatusLines = {

    hl = function()
        if conditions.is_active() then
            return "StatusLine"
        else
            return "StatusLineNC"
        end
    end,

    -- the first statusline with no condition, or which condition returns true is used.
    -- think of it as a switch case with breaks to stop fallthrough.
    fallthrough = false,

    SpecialStatusline, TerminalStatusline, InactiveStatusline, DefaultStatusline,
}

local WorkDir = {
  provider = function()
    local cwd = vim.fn.getcwd(0)
    cwd = vim.fn.fnamemodify(cwd, ":~")
    if not conditions.width_percent_below(#cwd, 0.33) then
      cwd = vim.fn.pathshorten(cwd)
    end
    local trail = cwd:sub(-1) == '/' and ' ' or "/ "
    return " " .. cwd .. trail
  end,
  hl = { bg = "purple", ctermbg = "purple_ct", fg = "bright_bg", ctermfg = "bright_bg_ct" },
}

local is_not_float_win = function(winid)
  return vim.api.nvim_win_get_config(winid).relative == ''
end

local TabName = {
  provider = function(self)
    local win_ids = vim.tbl_filter(is_not_float_win, vim.api.nvim_tabpage_list_wins(self.tabpage))
    local modified = function(self)
      for _,win_id in ipairs(win_ids) do
        if pcall(vim.api.nvim_win_get_buf, win_id) then
          local bufid = vim.api.nvim_win_get_buf(win_id)
          if vim.api.nvim_buf_get_option(bufid, "modified") then
            return " +"
          end
        end
      end
      return ""
    end
    local filename = function(self)
      for _,win_id in ipairs(win_ids) do
        if pcall(vim.api.nvim_win_get_buf, win_id) then
          local bufid = vim.api.nvim_win_get_buf(win_id)
          fn = vim.api.nvim_buf_get_name(bufid)
          fn = fn == "" and "[No Name]" or vim.fn.fnamemodify(fn, ":t")
        end
      end
      return fn
    end
    local num_wins = #win_ids
    local tab = num_wins == 1 and filename(self) or num_wins

    return "%" .. self.tabnr .. "T " .. self.tabnr .. ":" .. tab .. modified(self) .. " "
  end,
  hl = function(self)
    if not self.is_active then
      return { fg = "bright_fg", ctermfg = "bright_fg_ct", bg = "bright_bg", ctermbg = "bright_bg_ct" }
    else
      return { fg = "bright_bg", ctermfg = "bright_bg_ct", bg = "bright_fg", ctermbg = "bright_fg_ct" }
    end
  end,
}

local TabPages = {
  -- only show this component if there are 2 or more tabpages
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  utils.make_tablist(TabName),
}

local function make_tabwinlist(win_component)
  local winlist = {
    init = function(self)
      if self.is_active then
        local win_ids = vim.tbl_filter(is_not_float_win, vim.api.nvim_tabpage_list_wins(self.tabpage))
        self.num_wins = #win_ids
        for i, win_id in ipairs(win_ids) do
          local child = self[i]
          if not (child and child.win_id == win_id) then
            self[i] = self:new(win_component, i)
            child = self[i]
            child.win_id = win_id
            child.win_idx = i
          end
          local buf_id = vim.api.nvim_win_get_buf(win_id)
          child.buf_id = buf_id
          local filename = vim.api.nvim_buf_get_name(buf_id)
          filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
          child.filename = filename
        end
        if #self > #win_ids then
          for i = #self, #win_ids + 1, -1 do
            self[i] = nil
          end
        end
      end
    end,
  }
  return winlist
end

local WinName = {
  provider = function(self)
    return self.filename
  end,
}

local WinSeparator = {
  condition = function(self)
    return not (self.win_idx == self.num_wins)
  end,
  hl = { fg = "cyan", ctermfg = "cyan_ct" },
  Separator,
}

local WinNames = {
  condition = function(self)
    return (self.num_wins > 1 and self.is_active)
  end,
  { Space, WinName, Space, WinSeparator, },
}

local WinList = {
  -- only show this component if there are 2 or more tabpages
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  flexible = 2,
  hl = { fg = "bright_fg", ctermfg = "bright_fg_ct", bg = "bright_bg", ctermbg = "bright_bg_ct" },
  utils.make_tablist(make_tabwinlist(WinNames)),
  { provider = "", },
}

local TabLine = {
  WorkDir,TabPages,Align,WinList,
}

require("heirline").setup({
    statusline = StatusLines,
    tabline = TabLine,
    opts = {
        colors = setup_colors,
    }
})

-- Options to enable tabline
vim.o.showtabline = 2
--vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        utils.on_colorscheme(setup_colors)
    end,
    group = "Heirline",
})
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         utils.on_colorscheme(setup_colors)
--     end,
--     group = "Heirline",
-- })
