require('telescope').setup{
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
                width = 0.8,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        }
    }
}
