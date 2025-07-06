return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  opts = {
    window = {
      position = "float",
      width = 40,
      height = 30,
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        hide_by_name = {
          ".git",
          "node_modules",
          "vendor",
        },
      },
    },
  },
}
