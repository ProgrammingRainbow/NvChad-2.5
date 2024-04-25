local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        cpp = { "clang_format" },
        c = { "clang_format" },
        python = { "isort", "black" },
        -- css = { "prettier" },
        -- html = { "prettier" },
    },

    formatters = {
        clang_format = {
            prepend_args = {
                "-style={ \
                IndentWidth: 4, \
                TabWidth: 4, \
                UseTab: Never, \
                AccessModifierOffset: 0, \
                IndentAccessModifiers: true \
                }",
            },
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
