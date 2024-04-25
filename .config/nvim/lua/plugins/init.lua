return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.nvim-lint")
        end,
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-nvim-lint")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "mason.nvim" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cmake",
                "cpp",
                "css",
                "fish",
                "forth",
                "go",
                "haskell",
                "html",
                "javascript",
                "lua",
                "make",
                "markdown",
                "python",
                "rust",
                "ruby",
                "vim",
                "vimdoc",
            },
        },
    },

    -- {
    --     "rshkarin/mason-nvim-lint",
    --     event = "VeryLazy",
    --     dependencies = { "mason" },
    --     config = function()
    --         require("mason-nvim-lint").setup()
    --         require("mason-nvim-lint").setup_handlers {
    --             function(server_name)
    --                 require("nvim-lint")[server_name].setup {}
    --             end,
    --         }
    --     end,
    -- },

    -- {
    --     "yutaro-sakamoto/tree-sitter-cobol",
    --     event = { "VeryLazy", "BufRead */COBOL/*.conf" },
    --     -- event = "VeryLazy",
    --     config = function()
    --         require("nvim-treesitter.install").prefer_git = true
    --         require("nvim-treesitter.parsers").get_parser_configs().COBOL = {
    --             install_info = {
    --                 url = "https://github.com/yutaro-sakamoto/tree-sitter-cobol",
    --                 files = { "src/parser.c", "src/scanner.c" },
    --                 branch = "main",
    --             },
    --             filetype = "COBOL",
    --         }
    --         vim.treesitter.language.register("COBOL", { "COBOL" })
    --     end,
    -- },
}
