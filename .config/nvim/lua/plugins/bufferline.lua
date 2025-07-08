return {
    'akinsho/bufferline.nvim',
     version = "*",
     dependencies = 'nvim-tree/nvim-web-devicons',
     config = function()
        require("bufferline").setup({
            options = {
                numbers = "buffer_id",        -- show buffer id
                separator_style = "slant",    -- slanted separators
                show_buffer_close_icons = true,
                show_close_icon = false,
                diagnostics = "nvim_lsp",     -- show LSP diagnostics
        },
    })
     end,
}
