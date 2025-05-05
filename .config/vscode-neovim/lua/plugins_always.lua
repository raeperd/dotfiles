return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimKeymapsDefaults',
        callback = function()
          -- VSCode-specific keymaps for search and navigation
          vim.keymap.set('n', '<leader><space>', '<cmd>Find<cr>')
          vim.keymap.set('n', '<leader>/', [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]])
          vim.keymap.set('n', '<leader>ss', [[<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<cr>]])

          -- Keep undo/redo lists in sync with VsCode
          vim.keymap.set('n', 'u', '<Cmd>call VSCodeNotify("undo")<CR>')
          vim.keymap.set('n', '<C-r>', '<Cmd>call VSCodeNotify("redo")<CR>')

          -- Navigate VSCode tabs like lazyvim buffers
          vim.keymap.set('n', '<S-h>', '<Cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>')
          vim.keymap.set('n', '<S-l>', '<Cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>')
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc', 'go', 'python' },
        auto_install = true,
        highlight = { enable = false }, -- Disable highlight in VSCode
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['ii'] = '@conditional.inner',
              ['ai'] = '@conditional.outer',
              ['il'] = '@loop.inner',
              ['al'] = '@loop.outer',
              ['at'] = '@comment.outer',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']f'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']F'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[F'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },

  { 'numToStr/Comment.nvim' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  { "folke/ts-comments.nvim" },

  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>',  function() return require('dial.map').inc_normal() end,  expr = true, desc = 'Increment', mode = { 'n', 'v' } },
      { '<C-x>',  function() return require('dial.map').dec_normal() end,  expr = true, desc = 'Decrement', mode = { 'n', 'v' } },
      { 'g<C-a>', function() return require('dial.map').inc_gnormal() end, expr = true, desc = 'Increment', mode = { 'n', 'v' } },
      { 'g<C-x>', function() return require('dial.map').dec_gnormal() end, expr = true, desc = 'Decrement', mode = { 'n', 'v' } },
    },
    config = function()
      local augend = require('dial.augend')
      local logical_alias = augend.constant.new({
        elements = { '&&', '||' },
        word = false,
        cyclic = true,
      })

      local ordinal_numbers = augend.constant.new({
        elements = {
          'first', 'second', 'third', 'fourth', 'fifth',
          'sixth', 'seventh', 'eighth', 'ninth', 'tenth',
        },
        word = false,
        cyclic = true,
      })

      local weekdays = augend.constant.new({
        elements = {
          'Monday', 'Tuesday', 'Wednesday', 'Thursday',
          'Friday', 'Saturday', 'Sunday',
        },
        word = true,
        cyclic = true,
      })

      local months = augend.constant.new({
        elements = {
          'January', 'February', 'March', 'April', 'May', 'June',
          'July', 'August', 'September', 'October', 'November', 'December',
        },
        word = true,
        cyclic = true,
      })

      local capitalized_boolean = augend.constant.new({
        elements = { 'True', 'False' },
        word = true,
        cyclic = true,
      })

      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          ordinal_numbers,
          weekdays,
          months,
          capitalized_boolean,
          augend.constant.alias.bool,
          logical_alias,
        },
        vue = {
          augend.constant.new({ elements = { 'let', 'const' } }),
          augend.hexcolor.new({ case = 'lower' }),
          augend.hexcolor.new({ case = 'upper' }),
        },
        typescript = {
          augend.constant.new({ elements = { 'let', 'const' } }),
        },
        css = {
          augend.hexcolor.new({ case = 'lower' }),
          augend.hexcolor.new({ case = 'upper' }),
        },
        markdown = {
          augend.constant.new({
            elements = { '[ ]', '[x]' },
            word = false,
            cyclic = true,
          }),
          augend.misc.alias.markdown_header,
        },
        json = {
          augend.semver.alias.semver,
        },
        lua = {
          augend.constant.new({
            elements = { 'and', 'or' },
            word = true,
            cyclic = true,
          }),
        },
        python = {
          augend.constant.new({
            elements = { 'and', 'or' },
          }),
        },
      })

      vim.g.dials_by_ft = {
        css = 'css',
        vue = 'vue',
        javascript = 'typescript',
        typescript = 'typescript',
        typescriptreact = 'typescript',
        javascriptreact = 'typescript',
        json = 'json',
        lua = 'lua',
        markdown = 'markdown',
        sass = 'css',
        scss = 'css',
        python = 'python',
      }
    end,
  },

  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gx').setup {
        open_browser_app = 'open',
        open_browser_args = { '--background' },
        handlers = {
          plugin = true,
          github = true,
          brewfile = true,
          package_json = true,
          search = true,
          go = true,
        },
        handler_options = {
          search_engine = 'google',
          select_for_search = 'false',
          git_remotes = { 'upstream', 'origin' },
          git_remote_push = true,
        },
      }
    end,
  },

}
