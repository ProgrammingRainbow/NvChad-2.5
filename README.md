# Installing NvChad Version 2.5
## Backup and remove old nvim config.
Backup old nvim config.
```
mv ~/.config/nvim ~/.config/nvim-old
```
Or remove old nvim config.
```
rm -rf ~/.config/nvim
```
Remove local/state and local/share
```
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```
## Install NvChad.
Install required packages.
```
sudo pacman -S --needed neovim xclip wl-clipboard unzip
```
Install NvChad config from https://nvchad.com/docs/quickstart/install
```
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```
Or this already configured version
```
git clone https://github.com/ProgrammingRainbow/NvChad-2.5 ~/.config/nvim && nvim
```
Edit the file `~/.config/nvim/lua/options.lua` to change tabs from 2 to 4 spaces. \
Original config is here https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/options.lua
```
-- local o = vim.o
```
To this.
```
local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

```
Edit `~/.config/nvim/.stylua.toml` to change indent width to 4 and to use parentheses.
```
column_width = 120
line_endings = "Unix"
indent_type = "Spaces"
indent_width = 4
quote_style = "AutoPreferDouble"
# call_parentheses = "None"
```
## Setup Format and Style with Conform.
Edit `~/.config/nvim/lua/plugins/init.lua` to load module on save.
```
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },
```
Edit `~/.config/nvim/lua/configs/conform.lua` to enable format_on_save.
```
local options = {
    formatters_by_ft = {
        lua = { "stylua" },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
```
## Setup Treesitter
https://github.com/nvim-treesitter/nvim-treesitter \
Added to the Top of `~/.config/nvim/lua/plugins/init.lua`. 
```
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.nvim-treesitter")
        end,
    },
```
Create file `~/.config/nvim/lua/configs/nvim-treesitter.lua`. \
Copy from the internal one.
https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/treesitter.lua
```
local options = {
    ensure_installed = {
        "bash",
        "fish",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
```

## Basic Treesitter commands.
List Treesitter installed languages.
```
:TSInstallInfo
```
Install fish for treesitter.
```
:TSInstall fish
```
Update fish.
```
:TSUpdate fish
```
Update all.
```
:TSUpdate
```
Disable treesitter highlighting.
```
:TSDisable highlight
```
Enable treesitter highlighting.
```
:TSEnable highlight
```
## Treesitter language for filetype.
Check loaded treesitter language.
```
:lua print(require"nvim-treesitter.parsers".get_buf_lang())
```
or
```
:Inspect
```
Check filetype of buffer.
```
:echo &filetype
```
or
```
:set filetype?
```
Set filetype.
```
:set filetype=fish
```
## Setup LSPConfig.
https://github.com/neovim/nvim-lspconfig \
Edit file `~/.config/nvim/lua/plugins/init.lua`. \
Under Treesitter add an lspconfig entry.
```
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },
```
Edit file `~/.config/nvim/lua/configs/lspconfig.lua`. \
We will be adding a table that has a list of all servers configured. \
This will be used later in the mason-lspconfig to automate there installation. \
Then we will have a simple default_servers table for looping and setting up default configs. \
Using the NvChad default lua_ls found \
here https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/lspconfig.lua \
we will add love2d support `"${3rd}/love2d/library",` but also disable linting diagnostics.
```
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
}

-- list of servers configured with default config.
local default_servers = {}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

require("lspconfig").lua_ls.setup({
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
```
## Setting up Linting.
https://github.com/mfussenegger/nvim-lint \
Edit file `~/.config/nvim/lua/plugins/init.lua`. \
Between LSPConfig and Confom add an entry for Linting.
```
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },
```
Create file `~/.config/nvim/lua/configs/lint.lua`. \
`lint.linters_by_ft` is a key, value table for all linters to be configured. \
`lint.linters.laucheck.args = {` Will over write the arguments table for luacheck. \
To get the default args before editing use this command \
`:lua print(vim.inspect(require('lint').linters.luacheck.args))`. \
Create an auto command to run the linter when opeing a buffer, saving or leaving insert mode.
```
local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
}

lint.linters.luacheck.args = {
    "--globals",
    "love",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
```
## Setting up mason-conform.
https://github.com/zapling/mason-conform.nvim \
Edit the file `~/.config/nvim/lua/plugins/init.lua`. \
Below the conform entry add mason-conform.
```
    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },
```
Create the file `~/.config/nvim/lua/configs/mason-conform.lua`. \
Any formatters you don't wish to auto install add to ignore_install table.
```
require("mason-conform").setup({
    -- List of formatters to ignore during install
    ignore_install = {},
})
```
## Setting up mason-lspconfig.
https://github.com/williamboman/mason-lspconfig.nvim \
Edit the file `~/.config/nvim/lua/plugins/init.lua`. \
Below the lspconfig entry add mason-lspconfig.
```
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },
```
Create the file `~/.config/nvim/lua/configs/mason-lspconfig.lua`. \
This entire file is simply creating a table of servers to pass into ensure_installed. \
There is also a table at the top to add any server that should not be installed.
```
local lspconfig = package.loaded["lspconfig"]

-- List of servers to ignore during install
local ignore_install = {}

-- Helper function to find if value is in table.
local function table_contains(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

-- Build a list of lsp servers to install minus the ignored list.
local all_servers = {}
for _, s in ipairs(lspconfig.servers) do
    if not table_contains(ignore_install, s) then
        table.insert(all_servers, s)
    end
end

require("mason-lspconfig").setup({
    ensure_installed = all_servers,
    automatic_installation = false,
})
```
## Setting up mason-lint.
https://github.com/rshkarin/mason-nvim-lint \
Edit the file `~/.config/nvim/lua/plugins/init.lua`. \
Below the lint entry add mason-lint.
```
    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },
```
Create the file `~/.config/nvim/lua/configs/mason-lint.lua`. \
This entire file is simply creating a table of linters to pass into ensure_installed. \
There is also a table at the top to add any linter that should not be installed.
```
local lint = package.loaded["lint"]

-- List of linters to ignore during install
local ignore_install = {}

-- Helper function to find if value is in table.
local function table_contains(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

-- Build a list of linters to install minus the ignored list.
local all_linters = {}
for _, v in pairs(lint.linters_by_ft) do
    for _, linter in ipairs(v) do
        if not table_contains(ignore_install, linter) then
            table.insert(all_linters, linter)
        end
    end
end

require("mason-nvim-lint").setup({
    ensure_installed = all_linters,
    automatic_installation = false,
})
```
