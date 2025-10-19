-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.have_nerd_font = true
vim.g.have_transparent_bg = true
if vim.g.neovide then
  require("neovide")
end

require("config.lazy")
