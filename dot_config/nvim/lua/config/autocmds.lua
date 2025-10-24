-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- CursorLineNumberColor
local function set_cursorline_nr_color(mode)
  local colors = {
    n = "#8caaee", -- Normal frappe blue
    i = "#a6d189", -- Insert frappe green
    v = "#ca9ee6", -- Visual frappe mauve
  }

  local color = colors[mode]
  if color then
    vim.cmd("highlight CursorLineNr guifg=" .. color)
  end
end
-- Normal mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    set_cursorline_nr_color("n")
  end,
})
-- Insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    set_cursorline_nr_color("i")
  end,
})
-- Visual mode
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:[vV\x16]*",
  callback = function()
    set_cursorline_nr_color("v")
  end,
})
vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*:[n]",
  callback = function()
    set_cursorline_nr_color("n")
  end,
})
