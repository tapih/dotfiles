require('toggleterm').setup {
  open_mapping = [[<C-x>]],
  float_opts = {
    border = 'rounded',
  },
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
})

function _lazygit_toggle()
  lazygit:toggle()
end

