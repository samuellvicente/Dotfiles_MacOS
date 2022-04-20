local status_ok, util = pcall(require, "lspconfig.util")
if not status_ok then
  return
end

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


-- LTEX 
--
--local status_ok, configs = pcall(require, "lspconfig/configs")
--if not status_ok then
--  return
--end
--
--
--local Dictionary_file = {
--    ["en-GB"] = {vim.fn.stdpath('config') .. "spell/dictionary.txt"}
--}
--local DisabledRules_file = {
--    ["en-GB"] = {vim.fn.stdpath('config') .. "spell/disable.txt"}
--}
--local FalsePositives_file = {
--    ["en-GB"] = {vim.fn.stdpath('config') .. "spell/false.txt"}
--}
--
--local function readFiles(files)
--    local dict = {}
--    for _,file in ipairs(files) do
--        local f = io.open(file, "r")
--        for l in f:lines() do
--            table.insert(dict, l)
--        end
--    end
--    return dict
--end
--
--local function findLtexLang()
--    local buf_clients = vim.lsp.buf_get_clients()
--    for _, client in ipairs(buf_clients) do
--        if client.name == "ltex" then
--            return client.config.settings.ltex.language
--        end
--    end
--end
--
--local function findLtexFiles(filetype, value)
--    local files = nil
--    if filetype == 'dictionary' then
--        files = Dictionary_file[value or findLtexLang()]
--    elseif filetype == 'disable' then
--        files = DisabledRules_file[value or findLtexLang()]
--    elseif filetype == 'falsePositive' then
--        files = FalsePositives_file[value or findLtexLang()]
--    end
--
--    if files then
--        return files
--    else
--        return nil
--    end
--end
--
--local function updateConfig(lang, configtype)
--    local buf_clients = vim.lsp.buf_get_clients()
--    local client = nil
--    for _, lsp in ipairs(buf_clients) do
--        if lsp.name == "ltex" then
--            client = lsp
--        end
--    end
--
--    if client then
--        if configtype == 'dictionary' then
--            if client.config.settings.ltex.dictionary then
--                client.config.settings.ltex.dictionary = {
--                    [lang] = readFiles(Dictionary_file[lang])
--                };
--                return client.notify('workspace/didChangeConfiguration', client.config.settings)
--            else
--                return vim.notify("Error when reading dictionary config, check it")
--            end
--        elseif configtype == 'disable' then
--            if client.config.settings.ltex.disabledRules then
--                client.config.settings.ltex.disabledRules = {
--                    [lang] = readFiles(DisabledRules_file[lang])
--                };
--                return client.notify('workspace/didChangeConfiguration', client.config.settings)
--            else
--                return vim.notify("Error when reading disabledRules config, check it")
--            end
--
--        elseif configtype == 'falsePositive' then
--            if client.config.settings.ltex.hiddenFalsePositives then
--                client.config.settings.ltex.hiddenFalsePositives = {
--                    [lang] = readFiles(FalsePositives_file[lang])
--                };
--                return client.notify('workspace/didChangeConfiguration', client.config.settings)
--            else
--                return vim.notify("Error when reading hiddenFalsePositives config, check it")
--            end
--        end
--    else
--        return nil
--    end
--end
--
--local function addToFile(filetype, lang, file, value)
--    file = io.open(file[#file-0], "a+") -- add only to last file defined.
--    if file then
--        file:write(value .. "\n")
--        file:close()
--    else
--        return print("Failed insert %q", value)
--    end
--    if filetype == 'dictionary' then
--        return updateConfig(lang, "dictionary")
--    elseif filetype == 'disable' then
--        return updateConfig(lang, "disable")
--    elseif filetype == 'falsePositive' then
--        return updateConfig(lang, "disable")
--    end
--end
--
--local function addTo(filetype, lang, file, value)
--    local dict = readFiles(file)
--    for _, v in ipairs(dict) do
--        if v == value then
--            return nil
--        end
--    end
--    return addToFile(filetype, lang, file, value)
--end
--
--if not lspconfig.ltex then
--  configs.ltex = {
--    default_config = {
--      cmd = {"ltex-ls"};
--      filetypes = {'tex', 'bib', 'md'};
--      root_dir = function(fname)
--        return util.root_pattern '.latexmkrc'(fname) or util.find_git_ancestor(fname)
--      end;
--      settings = {
--        ltex = {
--          enabled= {"latex", "tex", "bib", "md"},
--          checkFrequency="save",
--          language="en-GB",
--          diagnosticSeverity="information",
--          setenceCacheSize=5000,
--          additionalRules = {
--            enablePickyRules = true,
--            motherTongue= "en-GB",
--          };
--          -- trace = { server = "verbose"};
--          -- ['ltex-ls'] = {
--          --     logLevel = "finest",
--          -- },
--          dictionary = {
--            ["en-GB"] = readFiles(Dictionary_file["en-GB"] or {}),
--          };
--          disabledRules = {
--            ["en-GB"] = readFiles(DisabledRules_file["en-GB"] or {}),
--          };
--          hiddenFalsePositives = {
--            ["en-GB"] = readFiles(FalsePositives_file["en-GB"] or {}),
--          };
--        },
--      };
--    };
--  };
--end
--
--lspconfig.ltex.setup {
--    on_attach = custom_attach,
--    capabilities = capabilities,
--    flags = {
--      debounce_text_changes = 150,
--    },
--}
--
--lspconfig.ltex.dictionary_file = Dictionary_file
--lspconfig.ltex.disabledrules_file = DisabledRules_file
--lspconfig.ltex.falsepostivies_file = FalsePositives_file
--
--
---- https://github.com/neovim/nvim-lspconfig/issues/858 can't intercept,
---- override it then.
--local orig_execute_command = vim.lsp.buf.execute_command
--vim.lsp.buf.execute_command = function(command)
--  if command.command == '_ltex.addToDictionary' then
--    local arg = command.arguments[1].words -- can I really access like this?
--    for lang, words in pairs(arg) do
--      for _, word in ipairs(words) do
--        local filetype = "dictionary"
--        addTo(filetype,lang, findLtexFiles(filetype,lang), word)
--      end
--    end
--  elseif command.command == '_ltex.disableRules' then
--    local arg = command.arguments[1].ruleIds -- can I really access like this?
--    for lang, rules in pairs(arg) do
--      for _, rule in ipairs(rules) do
--        local filetype = "disable"
--        addTo(filetype,lang,findLtexFiles(filetype,lang), rule)
--      end
--    end
--
--  elseif command.command == '_ltex.hideFalsePositives' then
--    local arg = command.arguments[1].falsePositives -- can I really access like this?
--    for lang, rules in pairs(arg) do
--      for _, rule in ipairs(rules) do
--        local filetype = "falsePositive"
--        addTo(filetype,lang,findLtexFiles(filetype,lang), rule)
--      end
--    end
--  else
--    orig_execute_command(command)
--  end
--end
--
--
-- LTEX 

lspconfig.texlab.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = function(fname)
    return util.root_pattern '.latexmkrc'(fname) or util.find_git_ancestor(fname)
  end,
  settings = {
    texlab = {
      auxDirectory = ".",
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = true,
        onSave = true,
      },
      chktex = {
        onEdit = true,
        onOpenAndSave = true
      },
      diagnosticsDelay = 50,
      formatterLineLength = 80,
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
      bibtexFormatter = "latexindent",
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false
      }
    }
  }
}

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



vim.lsp.set_log_level('debug')

return M
