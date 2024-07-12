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
Edit the file `~/.config/nvim/lua/options.lua`.
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
