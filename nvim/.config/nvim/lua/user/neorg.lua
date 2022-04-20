
-- NVIM neorg

local status_ok, configs = pcall(require, "neorg")
if not status_ok then
  return
end


configs.setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {
      config = {
        markup_preset = "dimmed",
        icon_preset = "diamond",
        dim_code_blocks = true,
      }
    }, -- Allows for use of icons
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          thesis = "~/Documents/IST/Thesis/neorg",
          personal = "~/Documents/Agenda/personal",
        },
        autochdir = true,
        autodetect = true,
        default_workspace = "thesis",
      }
    },
    ["core.norg.esupports.metagen"] = {
      config = {
        type = "auto",
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      }
    },
    ["core.norg.qol.toc"] = {
      config = {
        default_toc_mode = "split",
        toc_split_placement = "left",
        close_split_on_jump = false,
      }
    },
    ["core.keybinds"] = {
      config = {
        neorg_leader = "<Leader>",
      }
    },
    ["core.norg.esupports"] = {
      config = {
      },
    },
  }
}

