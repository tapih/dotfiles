return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Override the filename component to show full path
    opts.sections.lualine_c = {
      {
        "filename",
        path = 1, -- 0: just filename, 1: relative path, 2: absolute path
        shorting_target = 40, -- shortens path to leave 40 spaces in the window
        symbols = {
          modified = " ●", -- when the file was modified
          readonly = " ", -- if the file is not modifiable or readonly
          unnamed = "[No Name]", -- text to show for unnamed buffers
          newfile = "[New]", -- text to show for newly created file before first write
        },
      },
    }
  end,
}

