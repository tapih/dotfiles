return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle nvim-tree" },
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 40,
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.o.cmdheight
            local window_w = 40
            local window_h = 30
            return {
              relative = "editor",
              border = "rounded",
              width = window_w,
              height = window_h,
              row = math.floor((screen_h - window_h) / 2),
              col = math.floor((screen_w - window_w) / 2),
            }
          end,
        },
      },
      renderer = {
        icons = {
          webdev_colors = true,
        },
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
}
