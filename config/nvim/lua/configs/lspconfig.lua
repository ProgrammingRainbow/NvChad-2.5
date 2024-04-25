local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

lspconfig.servers = {
    "html",
    "cssls",
    -- "lua_ls",
    "pyright",
}

-- lsps with default config
for _, lsp in ipairs(lspconfig.servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

-- typescript
lspconfig.tsserver.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
})

lspconfig.clangd.setup({
    on_attach = on_attach,
    -- on_attach = function(client, bufnr)
    --     client.server_capabilities.signatureHelpProvider = false
    --     client.server_capabilities.documentFormattingProvider = false
    --     client.server_capabilities.documentRangeFormattingProvider = false
    --     on_attach(client, bufnr)
    -- end,
    on_init = on_init,
    capabilities = capabilities,
    -- cmd = { "clangd", "--clang-tidy", "--clang-tidy-checks=*", "--background-index" },
    -- cmd = {
    --     "clangd",
    --     "--background-index",
    --     "--clang-tidy",
    --     "--header-insertion=iwyu",
    --     "--completion-style=detailed",
    --     "--function-arg-placeholders",
    --     "--fallback-style=llvm",
    -- },
    -- args = {
    --     "--background-index",
    --     "--pch-storage=memory",
    --     "--clang-tidy",
    --     "--suggest-missing-includes",
    -- },

    -- cmd = {
    --     "clangd",
    --     "--background-index",
    --     "-j=12",
    --     "--clang-tidy",
    --     "--clang-tidy-checks=*",
    --     "--all-scopes-completion",
    --     "--cross-file-rename",
    --     "--completion-style=detailed",
    --     "--header-insertion-decorators",
    --     "--header-insertion=iwyu",
    --     "--pch-storage=memory",
    -- },
})
