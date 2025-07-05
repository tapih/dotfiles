return {
  "KEY60228/reviewthem.nvim",
  lazy = true,
  dependencies = {
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>rr", "<cmd>ReviewThemStart<cr>", desc = "Start Review" },
    { "<leader>rc", "<cmd>ReviewThemAddComment<cr>", desc = "Add Comment" },
    { "<leader>rk", "<cmd>ReviewThemSubmit<cr>", desc = "Submit Review" },
    { "<leader>ra", "<cmd>ReviewThemAbort<cr>", desc = "Abort Review" },
    { "<leader>rl", "<cmd>ReviewThemShowComments<cr>", desc = "Show Comments" },
    { "<leader>rt", "<cmd>ReviewThemToggleReviewed<cr>", desc = "Toggle Reviewed" },
    { "<leader>rs", "<cmd>ReviewThemStatus<cr>", desc = "Show Status" },
  },
  config = function()
    require("reviewthem").setup({})
  end,
}
