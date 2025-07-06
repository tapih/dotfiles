return {
  "snacks.nvim",
  opts = {
    lazygit = { enabled = true },
    snacks = {
      enabled = true,
      default = "scratch",
      scratch = {
        filetype = "markdown",
        name = "Scratch Buffer",
        autocmds = {
          { "BufEnter", "*", "setlocal nonumber norelativenumber" },
          { "FileType", "markdown", "setlocal wrap" },
        },
      },
    },
  },
  keys = {
    {
      "<leader>T",
      function()
        Snacks.scratch({ name = "TODO", ft = "markdown" })
      end,
      desc = "Open TODO Scratch Buffer",
    },
  },
}
