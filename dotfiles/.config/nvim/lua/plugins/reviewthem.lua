return {
  "KEY60228/reviewthem.nvim",
  dependencies = {
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>ab", "<cmd>ReviewThemStart<cr>", desc = "Start Review" },
    { "<leader>am", "<cmd>ReviewThemAddComment<cr>", desc = "Add Comment" },
    { "<leader>ao", "<cmd>ReviewThemSubmit<cr>", desc = "Submit Review" },
    { "<leader>ax", "<cmd>ReviewThemAbort<cr>", desc = "Abort Review" },
    { "<leader>al", "<cmd>ReviewThemShowComments<cr>", desc = "Show Comments" },
    { "<leader>at", "<cmd>ReviewThemToggleReviewed<cr>", desc = "Toggle Reviewed" },
    { "<leader>as", "<cmd>ReviewThemStatus<cr>", desc = "Show Status" },
  },
  config = function()
    require("reviewthem").setup({})
  end,
}
