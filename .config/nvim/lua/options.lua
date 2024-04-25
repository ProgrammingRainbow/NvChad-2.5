require("nvchad.options")

-- Indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.cmd([[ au BufRead,BufNewFile *.CBL set filetype=COBOL ]])
vim.treesitter.language.register("COBOL", { "COBOL" })
-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
