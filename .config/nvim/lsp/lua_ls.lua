-- lsp/lua_ls.lua
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          vim.fn.stdpath("config"),
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

