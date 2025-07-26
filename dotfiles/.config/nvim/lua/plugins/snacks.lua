return {
  "snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = true,
          -- exclude = {
          -- "**/.git/*",
          --},
        },
      },
    },
    scratch = {
      filetype = "markdown",
      name = "Scratch Buffer",
      autocmds = {
        { "BufEnter", "*", "setlocal nonumber norelativenumber" },
        { "FileType", "markdown", "setlocal wrap" },
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
