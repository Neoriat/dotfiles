return {
  -- other plugins …

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",           -- load on insert mode
    dependencies = {
      "L3MON4D3/LuaSnip",            -- snippet engine
      "saadparwaiz1/cmp_luasnip",    -- luasnip completion source for nvim-cmp
      "hrsh7th/cmp-nvim-lsp",        -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",          -- buffer words source
      "hrsh7th/cmp-path",            -- filesystem paths
      "hrsh7th/cmp-cmdline",         -- : and / completion
      "onsails/lspkind-nvim",        -- vs-code like icons for completion
      "rafamadriz/friendly-snippets",-- a bunch of community snippets
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        experimental = {
          ghost_text = true,
        },
      })

      -- / cmdline setup
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- : cmdline setup
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })

      -- Setup LSP capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Example for clangd; repeat for your servers:
      require("lspconfig").clangd.setup {
        capabilities = capabilities,
      }
    end,
  },

  -- … other plugins
}

