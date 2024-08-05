local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- c = { "clang-format" },
        -- cpp = { "clang-format" },
        -- go = { "gofumpt", "goimports-reviser", "golines" },
        -- gomod = { "gofumpt", "goimports-reviser" },
        -- gowork = { "gofumpt", "goimports-reviser" },
        -- gotmpl = { "gofumpt", "goimports-reviser" },
    },

    -- formatters = {
    --     ["clang-format"] = {
    --         prepend_args = {
    --             "-style={ \
    --                 IndentWidth: 4, \
    --                 TabWidth: 4, \
    --                 UseTab: Never, \
    --                 AccessModifierOffset: 0, \
    --                 IndentAccessModifiers: true, \
    --                 PackConstructorInitializers: Never}",
    --         },
    --     },
    --     ["goimports-reviser"] = {
    --         prepend_args = { "-rm-unused" },
    --     },
    --     golines = {
    --         prepend_args = { "--max-len=80" },
    --     },
    -- },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
