local M = {}

function M.show_line_diagnostics()
  local opts = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = 'rounded',
    source = 'always',  -- show source in diagnostic popup window
    prefix = ' '
  }
  vim.diagnostic.open_float(nil, opts)
end

local custom_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = false }

  -- Mappings.
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  --buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  --buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setqflist({open = true})<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  --buf_set_keymap('n', "<leader>e", "<cmd>lua require('user.lsp').show_line_diagnostics()<CR>", opts)

  vim.cmd([[ autocmd CursorHold <buffer> lua require('user.lsp').show_line_diagnostics() ]])

  -- Set some key bindings conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
  end

end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end


-- Setup global options
--local servers = { 'ccls' }
--for _, lsp in ipairs(servers) do
--  lspconfig[lsp].setup {
--    on_attach = custom_attach,
--    capabilities = capabilities,
--    flags = {
--      debounce_text_changes = 150,
--    }
--  }
--end

-- ccls options
-- lspconfig.ccls.setup {
--   on_attach = custom_attach,
--   capabilities = capabilities,
--   flags = {
--     debounce_text_changes = 150,
--   },
--   init_options = {
--     compilationDatabaseDirectory = ""; -- FIXME
--     index = {
--       threads = 0;
--     };
--     clang = {
--       excludeArgs = { "-frounding-math"} ;
--     };
--   }
-- }

-- configure signs
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- global config for diagnostic
vim.diagnostic.config({
  update_in_insert = true,
  underline = false,
  virtual_text = false,
  signs = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  border = "rounded",
})

return M
