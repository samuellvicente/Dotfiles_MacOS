-- NVIM treesiter

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- NeOrg TS subparsers
local status_ok, parsers = pcall(require, "nvim-treesitter.parsers")
if not status_ok then
  return
end

parsers.get_parser_configs().norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}
parsers.get_parser_configs().norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}

configs.setup {
  ensure_installed = {  "bash", "beancount", "bibtex", "c", "c_sharp", "clojure", "cmake", "comment", "commonlisp", "cpp", "css", "cuda", "dart", "devicetree", "dockerfile", "dot", "eex", "elixir", "erlang", "fennel", "fish", "fusion", "gdscript", "gleam", "glimmer", "glsl", "go", "godot_resource", "gomod", "gowork", "graphql", "jsdoc", "json", "json5", "jsonc", "julia", "kotlin", "lalrpop", "latex", "ledger", "llvm", "lua", "make", "ninja", "nix", "norg", "norg_meta", "norg_table", "ocaml", "ocaml_interface", "ocamllex", "pascal", "perl", "php", "pioasm", "prisma", "pug", "python", "ql", "query", "r", "rasi", "regex", "rst", "ruby", "rust", "scala", "scss", "sparql", "supercollider", "surface", "svelte", "teal", "tlaplus", "toml", "tsx", "turtle", "typescript", "vala", "vim", "vue", "yaml", "yang", "zig" },
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
