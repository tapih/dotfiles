return {
  "alexghergh/nvim-tmux-navigation",
  config = function()
    require("nvim-tmux-navigation").setup({
      disable_when_zoomed = true,
      keybindings = {
        left = "<C-Left>",
        down = "<C-Down>",
        up = "<C-Up>",
        right = "<C-Right>",
      },
    })
  end,
}

