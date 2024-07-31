local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- c_cpp = { "clang-format" }, -- Hack to force download.
        -- c = { "clang_format" },
        -- cpp = { "clang_format" },
    },

    -- formatters = {
    --     clang_format = {
    --         prepend_args = {
    --             "-style={ \
    --             IndentWidth: 4, \
    --             TabWidth: 4, \
    --             UseTab: Never, \
    --             AccessModifierOffset: 0, \
    --             IndentAccessModifiers: true, \
    --             PackConstructorInitializers: Never}",
    --         },
    --     },
    -- },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
