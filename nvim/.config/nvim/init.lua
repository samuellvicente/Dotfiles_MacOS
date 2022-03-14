-- Add options
require 'user/options'

-- Add keymaps
require 'user/keymaps'

-- Add plugins
require 'user/plugins'

-- Add colorscheme
local status_ok, color = pcall(require, "user/colorscheme")
if status_ok then
  color.DARK()
end


-- Add completion
require 'user/completion'

-- Add autocommands
require 'user/autocommands'

-- Add treesitter
require 'user/treesitter'

-- Add lsp
require 'user/lsp'

-- Add NeOrg
require 'user/neorg'
