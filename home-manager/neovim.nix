{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
        -- Visuals
        require('kanagawa').setup({ transparent = true })
        vim.cmd("colorscheme kanagawa-wave")
        vim.cmd("set cursorline")
        vim.cmd("set number relativenumber")
        vim.api.nvim_set_hl(0, "Normal", { bg = nil })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = nil })
        vim.opt.termguicolors = true
        vim.opt.scrolloff = 8
        vim.opt.colorcolumn = "80"
        vim.opt.signcolumn = "yes"

        -- Use system clipboard
        vim.opt.clipboard = 'unnamedplus'

        -- Tabs
        vim.opt.tabstop = 4
        vim.opt.softtabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.smartindent = true
        vim.opt.wrap = false

        -- Searching
        vim.opt.hlsearch = false
        vim.opt.incsearch = true

        -- Swap files
        vim.opt.swapfile = false
        vim.opt.backup = false
        vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
        vim.opt.undofile = true

        -- Show unnecessary whitespace
        vim.opt.list = true
        vim.opt.listchars = {
            trail = '·',
            tab = '▸-',
            nbsp = '␣',
            extends = '⟩',
            precedes = '⟦',
        }

        -- Testing
        -- vim.opt.isfname:append("@-@") -- Dont know what this does yet.
        -- vim.opt.updatetime = 50 -- Dont think this does anything.
    '';

    plugins = with pkgs.vimPlugins; [
      kanagawa-nvim
      gruvbox-nvim
      gruvbox-material-nvim

      # nvim-lspconfig
      # nvim-treesitter.withAllGrammars
      # plenary-nvim
      # mini-nvim
    ];
  };
}
