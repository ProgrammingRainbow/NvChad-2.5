local lint = require("lint")

lint.linters_by_ft = {
    python = { "pylint" },
}

lint.linters.pylint.args = {
    "-f",
    "json",
    "--disable=too-many-instance-attributes",
    "--disable=missing-function-docstring",
    "--disable=missing-module-docstring",
    "--disable=missing-class-docstring",
}

-- local lint_augroup = vim.api.nvim_create_autocmd("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    -- group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})
