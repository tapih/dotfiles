return {
  "bennypowers/splitjoin.nvim",
  lazy = true,
  keys = {
    {
      "g.",
      function()
        require("splitjoin").join()
      end,
      desc = "Join the object under cursor",
    },
    {
      "g,",
      function()
        require("splitjoin").split()
      end,
      desc = "Split the object under cursor",
    },
  },
}
