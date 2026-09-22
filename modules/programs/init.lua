vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.termguicolors = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("OSC52Yank", { clear = true }),
  callback = function()
    if vim.v.event.operator == "y" then
      vim.fn.setreg("+", vim.fn.getreg('"'))
    end
  end,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set({"n", "v"}, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({ transparent_mode = true })
      vim.cmd("colorscheme gruvbox")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { theme = "auto" },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>" },
    },
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "ThePrimeagen/vim-be-good" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ current_line_blame = true })
      vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next Git Hunk" })
      vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Prev Git Hunk" })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "html", "css" },
        highlight = { enable = true },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format file",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, { range = true, desc = "Format buffer or range" })
    end,
    opts = {
      formatters_by_ft = {
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
      },
      formatters = {
        biome = {
          prepend_args = {
            "--indent-style=space",
            "--indent-width=2",
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          path = {
            opts = {
              get_cwd = function(_)
                return vim.fn.expand("%:p:h")
              end,
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("biome", { 
        capabilities = capabilities 
      })
      vim.lsp.enable("biome")
      
      vim.lsp.config("vtsls", { 
        capabilities = capabilities,
        settings = {
          typescript = {
            suggest = { autoImports = true },
            updateImportsOnFileMove = { enabled = "always" },
            preferences = {
              importModuleSpecifier = "non-relative",
              importModuleSpecifierPreference = "non-relative",
              includePackageJsonAutoImports = "on",            
            },
            tsserver = {
              watchOptions = { watchFile = "PriorityPollingInterval" }
            }
          },
          javascript = {
            suggest = { autoImports = true },
            updateImportsOnFileMove = { enabled = "always" },
            preferences = {
              importModuleSpecifier = "non-relative",
              importModuleSpecifierPreference = "non-relative",
              includePackageJsonAutoImports = "on",
            },
          },
        },
      })
      vim.lsp.enable("vtsls")
      
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open Diagnostics" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      
      local function apply_action(client, action, bufnr)
        if not action.edit and not action.command then
          local ok, resolved = pcall(function()
            return client:request_sync("codeAction/resolve", action, 1000, bufnr)
          end)
          if ok and resolved and resolved.result then
            action = resolved.result
          end
        end

        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
        end
        if action.command then
          local command = type(action.command) == "table" and action.command or action
          client:request_sync("workspace/executeCommand", command, 1000, bufnr)
        end
      end

      local function make_full_range_params(bufnr)
        local last_line = vim.api.nvim_buf_line_count(bufnr) - 1
        return {
          textDocument = vim.lsp.util.make_text_document_params(bufnr),
          range = {
            start = { line = 0, character = 0 },
            ["end"] = { line = last_line, character = 2147483647 },
          },
        }
      end

      local function run_code_action(bufnr, client_name, kind)
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        local client = vim.lsp.get_clients({ bufnr = bufnr, name = client_name })[1]
        if not client then return end

        local params = make_full_range_params(bufnr)
        params.context = { only = { kind }, diagnostics = {} }

        local resp = client:request_sync("textDocument/codeAction", params, 1000, bufnr)
        if not resp or not resp.result then return end

        for _, action in ipairs(resp.result) do
          apply_action(client, action, bufnr)
        end
      end

      _G.organize_imports = function(bufnr) run_code_action(bufnr, "biome", "source.organizeImports.biome") end
      _G.add_missing_imports = function(bufnr) run_code_action(bufnr, "vtsls", "source.addMissingImports.ts") end

      vim.keymap.set("n", "<leader>co", function() organize_imports() end, { desc = "Organize Imports" })
      vim.keymap.set("n", "<leader>ci", function() add_missing_imports() end, { desc = "Add Missing Imports" })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
        callback = function(args)
          organize_imports(args.buf)
        end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
  },
})
