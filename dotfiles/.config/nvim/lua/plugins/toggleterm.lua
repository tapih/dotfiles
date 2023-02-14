require('toggleterm').setup {
  open_mapping = [[<C-x>]],
  float_opts = {
    border = 'rounded',
  },
}

function _lazygit_toggle()
  local Terminal  = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    direction = "float",
    hidden = true,
  })

  lazygit:toggle()
end

function _terminal_toggle()
  local Terminal  = require('toggleterm.terminal').Terminal
  local terminal = Terminal:new({
    direction = "float",
    hidden = true,
  })

  terminal:toggle()
end

