local lint = package.loaded["lint"]
local all_linters = {}

for _, v in pairs(lint.linters_by_ft) do
    for _, linter in pairs(v) do
        table.insert(all_linters, linter)
    end
end
require("mason-nvim-lint").setup {
    ensure_installed = all_linters,
    automatic_installation = true,
}
