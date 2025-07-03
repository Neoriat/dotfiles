return {
    "nvim-treesitter/nvim-treesitter", 
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "lua", "python", "javascript", "html", "json", "bash", "typescript", "css", "rust"
        },
        sync_install = false,      -- install parsers async
        auto_install = true,       -- auto-install missing parsers on BufRead
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,           -- experimental indentation
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  } 

