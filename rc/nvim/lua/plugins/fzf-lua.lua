local template = [['if(self.branches(), self.branches().map(|b| if(b.remote(),b.name()++"@"++b.remote(),b.name())), self.commit_id().short())++" "++self.description().first_line()++"\n"']]

local extract_ref = function (line)
  return vim.iter(vim.gsplit(line, " ", {plain=true})):next()
end
local jj_actions = {
  ["default"] = function (selected)
    vim.fn.setreg("+", extract_ref(selected[1]))
  end,
  ["ctrl-r"] = function (selected)
    local ref = (extract_ref(selected[1]))
    local Input = require("nui.input")
    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event
    local popup = Popup({
      enter = true,
      focusable = true,
      border = {
        style = "rounded",
      },
      position = "50%",
      size = {
        width = "80%",
        height = "60%",
      },
    })
    local input = Input({
      position = "50%",
      size = {
        width = "50%",
      },
      border = {
        style = "single",
        text = {
          top = "[Run command on shell]",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "$ ",
      on_submit = function(cmd)
        local cmd = string.gsub(cmd, "{}", vim.fn.shellescape(ref))
        popup:on(event.BufLeave, function ()
          popup:unmount()
        end)
        popup:mount()
        vim.system(vim.print({vim.o.shell, vim.o.shellcmdflag, cmd}), {text=true},
          vim.schedule_wrap(
            function (o)
              vim.api.nvim_buf_set_lines(popup.bufnr, 0, 0, false, vim.list_extend(vim.split(o.stdout, "\n"), vim.split(o.stderr, "\n")))
            end
          )
        )
      end,
    })
    input:on(event.BufLeave, function ()
      input:unmount()
    end)
    input:mount()
  end
}

---@type LazySpec
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      grep = {
        actions = {
          ["ctrl-g"] = {require("fzf-lua.actions").toggle_ignore},
          ["ctrl-r"] = {require("fzf-lua.actions").grep_lgrep},
        }
      }
    },
    keys = {
      {"<Leader>fa", function() require'fzf-lua'.files({cwd="~/.config/nvim"}) end, desc = "Find config files"},
      {"<Leader>ff", function() require'fzf-lua'.files() end, desc = "Find files"},
      {"<Leader>f/", function() require'fzf-lua'.blines({resume=true}) end, desc = "Find words in current buffer"},
      {"<Leader>f?", function() require'fzf-lua'.lines({resume=true}) end, desc = "Find words buffers"},
      {"<Leader>fw", function() require'fzf-lua'.live_grep({resume=true}) end, desc = "Find words"},
      {"<Leader>fc", function() require'fzf-lua'.grep_cword() end, desc = "Find word under cursor"},
      {"<Leader>fk", function() require'fzf-lua'.keymaps() end, desc = "Find keymaps"},
      {"<Leader>fh", function() require'fzf-lua'.helptags() end, desc = "Find help"},
      {"<Leader>fm", function() require'fzf-lua'.manpages() end, desc = "Find man"},

      -- LSP keymap
      {"<Leader>ls", function() require'fzf-lua'.lsp_document_symbols() end, desc = "Find document symbols"},

      -- JJ keymap
      {"<Leader>jb", function() require'fzf-lua'.fzf_exec(
        vim.iter({
          "jj log",
          "-r 'visible_heads() | branches()'",
          "-T", template,
          "--no-graph", "--color", "always"
        }):join(" "),
        {
          preview = {
            type = "cmd",
            fn = function (items)
              local ref = vim.iter(vim.gsplit(items[1], " ", {plain=true})):next()
              return string.format("jj log -r '::%s' -n 1000 --color always", ref)
            end
          },
          actions = jj_actions,
        }
      ) end, desc = "Find heads and branches"},
      {"<Leader>jc", function() require'fzf-lua'.fzf_live(
        function (query)
          local q = vim.fn.shellescape(string.format('(branches(regex:"%s") | description(regex:"%s")) ~ empty()', query, query))
          return vim.iter({ "jj log", "-T", template, "--no-graph", "--color", "always", "-r", q}):join(" ")
        end,
        {
          preview = {
            type = "cmd",
            fn = function (items)
              local ref = vim.iter(vim.gsplit(items[1], " ", {plain=true})):next()
              return string.format("jj show -r '%s' --color always", ref)
            end
          },
          actions = jj_actions,
        }
      ) end, desc = "Find commits"},
    }
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {"<Leader>f", group = "Find something"},
        {"<Leader>j", group = "JJ"},
      }
    }
  }
}
