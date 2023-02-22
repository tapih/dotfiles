local ok, impatient = pcall(require, "impatient")

if ok then
  impatient.enable_profile()
end

require('init')
require('plugins')
require('keymaps')
