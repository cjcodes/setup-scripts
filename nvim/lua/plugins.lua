local opts = require('opts')

return {
  'numToStr/Comment.nvim',
  'nmac427/guess-indent.nvim',
  'mason-org/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'nvim-tree/nvim-web-devicons',
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
  {
    'mason-org/mason.nvim',
    lazy = false,
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<c-d>'] = require('telescope.actions').delete_buffer
            },
          },
        },
      })
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      integrations = {
        blink_cmp = true,
        treesitter = true,
        notify = true,
        mason = true,
        telescope = {
          enabled = true
        },
        which_key = true,
      }
    }
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      view = {
        width = 60,
      },
    },
  },
  {
    'nomnivore/ollama.nvim',
    enabled = opts.llm == 'ollama',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      model = 'qwen2.5-coder',
      serve = {
        on_start = true,
      },
    },
    keys = {
      {
        '<leader>oo',
        ':<c-u>lua require("ollama").prompt()<cr>',
        mode = { 'n', 'v' },
      },
      {
        '<leader>og',
        ':<c-u>lua require("ollama").prompt("Generate_Code")<cr>',
        mode = { 'n', 'v' },
      },
      {
        '<leader>om',
        ':<c-u>lua require("ollama").prompt("Modify_Code")<cr>',
        mode = { 'n', 'v' },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = opts.llm == 'copilot',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'fang2hou/blink-copilot',
    },
    opts = {
      sources = {
        default = { 'lsp', 'path', 'copilot', 'buffer' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
      completion = {
        menu = {
          auto_show = true,
        },
      },
      keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
      },
    },
  },
}
