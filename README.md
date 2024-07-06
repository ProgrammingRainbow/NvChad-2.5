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

`:MasonInstallAll`


`~/.config/nvim/lua/options.lua`
```
-- local o = vim.o
```
```
local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

```
