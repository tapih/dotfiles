return {
  "greggh/claude-code.nvim",
  config = true,
  opts = {
    window = {
      split_ratio = 0.3,
      position = "vertical",
    },
  },
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    { "<leader>ar", "<cmd>ClaudeCodeResume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCodeContinue<cr>", desc = "Continue Claude" },
  },
}
