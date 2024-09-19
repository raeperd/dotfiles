return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })
        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })
        -- Actions
        map('n', '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end)
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end)
        map('n', '<leader>td', gs.toggle_deleted)
        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope.nvim',
      -- Only one of these is needed, not both.
      -- optional
      'ibhagwan/fzf-lua', -- optional
    },
    config = function()
      local neogit = require 'neogit'
      neogit.setup {
        integrations = {
          diffview = true,
          fzf = true,
          telescope = true,
        },
      }
      vim.keymap.set('n', '<leader>gs', neogit.open, { desc = 'Neogit: Status' })
      vim.keymap.set('n', '<leader>gc', function()
        neogit.open { 'commit' }
      end, { desc = 'Neogit: Commit' })
      vim.keymap.set('n', '<leader>gp', function()
        neogit.open { 'pull' }
      end, { desc = 'Neogit: Pull' })
      vim.keymap.set('n', '<leader>gP', function()
        neogit.open { 'push' }
      end, { desc = 'Neogit: Push' })
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Search [g]it [b]ranches' })
    end,
  },
}
