local lspconfig = package.loaded["lspconfig"]

require("mason-lspconfig").setup({
    ensure_installed = lspconfig.servers,
    automatic_installation = true,
})
