local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- local lspconfig = require("lspconfig") -- pre nvim 0.11
local lspconfig = require("nvchad.configs.lspconfig") -- nvim 0.11

-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
    -- "clangd",
    -- "gopls",
    -- "hls",
    -- "ols",
    -- "pyright",
}

-- list of servers configured with default config.
local default_servers = {
    -- "ols",
    -- "pyright",
}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    -- lspconfig[lsp].setup({ -- pre nvim 0.11
    vim.lsp.config(lsp, { -- nvim 0.11
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

-- -- lspconfig.clangd.setup({ -- pre nvim 0.11
-- vim.lsp.config("clangd", { -- nvim 0.11
--     on_attach = function(client, bufnr)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--         on_attach(client, bufnr)
--     end,
--     on_init = on_init,
--     capabilities = capabilities,
-- })

-- -- lspconfig.gopls.setup({ -- pre nvim 0.11
-- vim.lsp.config("gopls", { -- nvim 0.11
--     on_attach = function(client, bufnr)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--         on_attach(client, bufnr)
--     end,
--     on_init = on_init,
--     capabilities = capabilities,
--     cmd = { "gopls" },
--     filetypes = { "go", "gomod", "gotmpl", "gowork" },
--     -- root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"), -- pre nvim 0.11
--     root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"), -- nvim 0.11
--     settings = {
--         gopls = {
--             analyses = {
--                 unusedparams = true,
--             },
--             completeUnimported = true,
--             usePlaceholders = true,
--             staticcheck = true,
--         },
--     },
-- })

-- -- lspconfig.hls.setup({ -- pre nvim 0.11
-- vim.lsp.config("hls", { -- nvim 0.11
--     on_attach = function(client, bufnr)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--         on_attach(client, bufnr)
--     end,
--
--     on_init = on_init,
--     capabilities = capabilities,
-- })

-- lspconfig.lua_ls.setup({ -- pre nvim 0.11
vim.lsp.config("lua_ls", { -- nvim 0.11
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})
