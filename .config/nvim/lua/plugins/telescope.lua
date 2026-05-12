return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    opts = {
        vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<cr>", { desc = 'Telescope find files' }),
        vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<cr>", { desc = 'Telescope live grep' }),
        vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<cr>", { desc = 'Telescope buffers' }),
    },
}
