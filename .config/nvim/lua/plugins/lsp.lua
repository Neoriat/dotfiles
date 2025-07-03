return {
  -- other plugins …

  -- Mason: external LSP/DAP/formatter installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSPConfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "pyright", "rust_analyzer", "bashls" },
      })
    end,
  },

  -- Core LSPConfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",       -- for capabilities
      "b0o/schemastore.nvim",       -- JSON schemas (optional)
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util      = require("lspconfig.util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Common on_attach for keymaps and formatting
      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs)
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs,
            { noremap = true, silent = true })
        end

        -- LSP-based navigation
        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
        bufmap("n", "K",  "<cmd>lua vim.lsp.buf.hover()<CR>")
        bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
        bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
        bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

        -- Diagnostics
        bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
        bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
        bufmap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
        bufmap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

        -- Formatting (if supported)
        if client.server_capabilities.documentFormattingProvider then
          bufmap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>")
        end
      end

      -- Example server setups
      lspconfig.ts_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
      }

      lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = { checkOnSave = { command = "clippy" } },
        },
      }

      -- JSON with schemas from schemastore
      lspconfig.jsonls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      }

      -- Bash
      lspconfig.bashls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- Add other servers here…
    end,
  },

  -- … other plugins
}
