return {
  "alexghergh/nvim-tmux-navigation",
  keys = {
    {
      "<C-Left>",
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
      end,
      desc = "Navigate left",
    },
    {
      "<C-Down>",
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateDown()
      end,
      desc = "Navigate down",
    },
    {
      "<C-Up>",
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateUp()
      end,
      desc = "Navigate up",
    },
    {
      "<C-Right>",
      function()
        require("nvim-tmux-navigation").NvimTmuxNavigateRight()
      end,
      desc = "Navigate right",
    },
  },
  config = function()
    require("nvim-tmux-navigation").setup({
      disable_when_zoomed = true,
    })
  end,
}
