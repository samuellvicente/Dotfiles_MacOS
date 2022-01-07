-- NVIM complete

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
  return
end
lspkind.init()

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end


-- Global setup
cmp.setup {
  --
  -- Mapping:
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- invoke completion
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<Tab>"] = cmp.config.disable,
  },
  --
  -- Sources
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 3},
    { name = "path" },
    --{ name = "luasnip" },
  },
  --
  -- Sorting
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      --require "cmp-under-comparator".under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  --
  -- Formatting
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        nvim_lsp = "[LSP]",
        buffer = "[Buf]",
        path = "[Path]",
        --nvim_lua = "[api]",
        --luasnip = "[snip]",
      },
    },
  },
  --
  -- Completion box look
  completion = { 
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, 
    scrollbar = "║" 
  },
  --
  -- Documentation box look
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    scrollbar = "║",
  },
  --
  -- Experimental
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  --
  -- Snippets
  --snippet = {
  --  expand = function(args)
  --    luasnip.lsp_expand(args.body) -- For `luasnip` users.
  --  end,
  --},
}
