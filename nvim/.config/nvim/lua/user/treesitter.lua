-- NVIM treesiter

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "maintained",
  sync_install = false,
  highlight = {
    enable = true,
    disable = { "" },
    --additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
    disable = { "" },
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  --autotag = {
  --  enable = true, -- for auto closing, renaming, deleting html tags
  --},
}
