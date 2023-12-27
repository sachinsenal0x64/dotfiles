vim.opt.number = true
vim.opt.conceallevel = 2
vim.opt.winbar = "image.nvim demo"
vim.opt.signcolumn = "yes:2"

local content = [[

# Hello World

![This is a remote image](https://gist.ro/s/remote.png)
]]

vim.schedule(function()
local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(buf, 0, -1, true, vim.split(content, "\n"))
vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
vim.api.nvim_set_current_buf(buf)
vim.cmd("split")
end)

![](~/dotfiles/lvim/pic.jpg)
