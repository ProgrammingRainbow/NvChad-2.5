local conform = package.loaded["conform"]
local all_formatters = {}

for _, v in pairs(conform.formatters_by_ft) do
    for _, formatter in pairs(v) do
        table.insert(all_formatters, formatter)
    end
end
require("mason-conform").setup {
    ensure_installed = all_formatters,
    automatic_installation = true,
}
